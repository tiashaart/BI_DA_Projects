import pandas as pd
import numpy as np
from faker import Faker
import random
import os

# ============================================================
# 1. SETUP
# ============================================================

fake = Faker()
random.seed(42)
np.random.seed(42)

os.makedirs("data", exist_ok=True)

# Number of candidates
N_CANDIDATES = 5000

# ============================================================
# 2. MASTER DATA
# ============================================================

universities = [
    "University of Colombo",
    "University of Peradeniya",
    "University of Moratuwa",
    "University of Sri Jayewardenepura",
    "University of Kelaniya",
    "South Eastern University of Sri Lanka",
    "University of Ruhuna",
    "Sabaragamuwa University",
    "Wayamba University",
    "Uva Wellassa University"
]

degrees = [
    "Computer Science",
    "Information Technology",
    "Data Science",
    "Software Engineering",
    "Business Management",
    "Finance",
    "Marketing",
    "Human Resource Management"
]

locations = [
    "Colombo",
    "Kandy",
    "Galle",
    "Jaffna",
    "Kurunegala",
    "Batticaloa",
    "Ampara",
    "Matara",
    "Anuradhapura",
    "Negombo"
]

sources = [
    "LinkedIn",
    "Referral",
    "University Career Fair",
    "Company Website",
    "Job Portal",
    "Email Campaign"
]

departments = [
    ("Data Analytics", 20),
    ("Software Engineering", 30),
    ("Business Analysis", 15),
    ("Finance", 10),
    ("Marketing", 10),
    ("Human Resources", 8)
]

# ============================================================
# 3. GENERATE CANDIDATES
# ============================================================

candidates = []

for i in range(1, N_CANDIDATES + 1):

    gender = random.choice(["Male", "Female"])

    candidate = {
        "candidate_id": i,
        "candidate_name": f"Candidate {i:04d}",
        "gender": gender,
        "age": random.randint(20, 26),
        "university": random.choice(universities),
        "degree": random.choice(degrees),
        "graduation_year": random.choice([2026, 2027, 2028]),
        "location": random.choice(locations),
        "source": random.choices(
            sources,
            weights=[25, 15, 15, 20, 20, 5]
        )[0]
    }

    candidates.append(candidate)

candidates_df = pd.DataFrame(candidates)

# ============================================================
# 4. GENERATE DEPARTMENTS
# ============================================================

departments_df = pd.DataFrame(
    departments,
    columns=["department_name", "internship_capacity"]
)

departments_df.insert(
    0,
    "department_id",
    range(1, len(departments_df) + 1)
)

# ============================================================
# 5. GENERATE APPLICATIONS
# ============================================================

applications = []

application_id = 1

for candidate_id in candidates_df["candidate_id"]:

    # Every candidate has one application
    application_date = fake.date_between(
        start_date="-12M",
        end_date="today"
    )

    department_id = random.randint(
        1,
        len(departments_df)
    )

    # Most applications start as Applied
    status = random.choices(
        [
            "Shortlisted",
            "Rejected",
            "Withdrawn"
        ],
        weights=[30, 60, 10]
    )[0]

    applications.append({
        "application_id": application_id,
        "candidate_id": candidate_id,
        "department_id": department_id,
        "application_date": application_date,
        "status": status
    })

    application_id += 1

applications_df = pd.DataFrame(applications)

# ============================================================
# 6. GENERATE ASSESSMENTS
# ============================================================

assessments = []

assessment_id = 1

for _, application in applications_df.iterrows():

    if application["status"] != "Shortlisted":
        continue

    assessment_date = pd.to_datetime(
        application["application_date"]
    ) + pd.Timedelta(days=random.randint(2, 10))

    score = np.clip(
        np.random.normal(70, 15),
        0,
        100
    )

    status = "Passed" if score >= 60 else "Failed"

    assessments.append({
        "assessment_id": assessment_id,
        "application_id": application["application_id"],
        "assessment_date": assessment_date.date(),
        "assessment_score": round(score, 2),
        "assessment_status": status
    })

    assessment_id += 1

assessments_df = pd.DataFrame(assessments)

# ============================================================
# 7. GENERATE INTERVIEWS
# ============================================================

interviews = []

interview_id = 1

passed_assessments = assessments_df[
    assessments_df["assessment_status"] == "Passed"
]

for _, assessment in passed_assessments.iterrows():

    application_id = assessment["application_id"]

    assessment_date = pd.to_datetime(
        assessment["assessment_date"]
    )

    interview_date = assessment_date + pd.Timedelta(
        days=random.randint(3, 14)
    )

    technical = np.clip(
        np.random.normal(72, 14),
        0,
        100
    )

    communication = np.clip(
        np.random.normal(70, 15),
        0,
        100
    )

    overall = (
        technical * 0.6 +
        communication * 0.4
    )

    status = "Passed" if overall >= 60 else "Failed"

    interviews.append({
        "interview_id": interview_id,
        "application_id": application_id,
        "interview_date": interview_date.date(),
        "interview_round": "Technical",
        "technical_score": round(technical, 2),
        "communication_score": round(communication, 2),
        "overall_score": round(overall, 2),
        "interview_status": status
    })

    interview_id += 1

interviews_df = pd.DataFrame(interviews)

# ============================================================
# 8. GENERATE FINAL INTERVIEWS
# ============================================================

final_interviews = []

final_interview_id = interview_id

technical_passed = interviews_df[
    interviews_df["interview_status"] == "Passed"
]

for _, interview in technical_passed.iterrows():

    application_id = interview["application_id"]

    first_date = pd.to_datetime(
        interview["interview_date"]
    )

    final_date = first_date + pd.Timedelta(
        days=random.randint(3, 10)
    )

    technical = np.clip(
        np.random.normal(75, 12),
        0,
        100
    )

    communication = np.clip(
        np.random.normal(73, 12),
        0,
        100
    )

    overall = (
        technical * 0.6 +
        communication * 0.4
    )

    status = "Passed" if overall >= 60 else "Failed"

    final_interviews.append({
        "interview_id": final_interview_id,
        "application_id": application_id,
        "interview_date": final_date.date(),
        "interview_round": "Final",
        "technical_score": round(technical, 2),
        "communication_score": round(communication, 2),
        "overall_score": round(overall, 2),
        "interview_status": status
    })

    final_interview_id += 1

final_interviews_df = pd.DataFrame(final_interviews)

interviews_df = pd.concat(
    [interviews_df, final_interviews_df],
    ignore_index=True
)

# ============================================================
# 9. GENERATE OFFERS
# ============================================================

offers = []

offer_id = 1

# Candidates who passed final interview
final_passed = final_interviews_df[
    final_interviews_df["interview_status"] == "Passed"
]

for _, interview in final_passed.iterrows():

    application_id = interview["application_id"]

    interview_date = pd.to_datetime(
        interview["interview_date"]
    )

    offer_date = interview_date + pd.Timedelta(
        days=random.randint(2, 10)
    )

    offer_status = random.choices(
        ["Accepted", "Rejected", "Pending"],
        weights=[70, 20, 10]
    )[0]

    joining_date = offer_date + pd.Timedelta(
        days=random.randint(14, 45)
    )

    offers.append({
        "offer_id": offer_id,
        "application_id": application_id,
        "offer_date": offer_date.date(),
        "stipend": random.choice(
            [20000, 25000, 30000, 35000, 40000]
        ),
        "offer_status": offer_status,
        "joining_date": joining_date.date()
    })

    offer_id += 1

offers_df = pd.DataFrame(offers)

# ============================================================
# 10. SAVE CSV FILES
# ============================================================

candidates_df.to_csv(
    "data/candidates.csv",
    index=False
)

departments_df.to_csv(
    "data/departments.csv",
    index=False
)

applications_df.to_csv(
    "data/applications.csv",
    index=False
)

assessments_df.to_csv(
    "data/assessments.csv",
    index=False
)

interviews_df.to_csv(
    "data/interviews.csv",
    index=False
)

offers_df.to_csv(
    "data/offers.csv",
    index=False
)

# ============================================================
# 11. SUMMARY
# ============================================================

print("\nDATASET CREATED SUCCESSFULLY\n")

print("Candidates:", len(candidates_df))
print("Applications:", len(applications_df))
print("Assessments:", len(assessments_df))
print("Interviews:", len(interviews_df))
print("Offers:", len(offers_df))

print("\nFiles created inside data/:")
print("candidates.csv")
print("departments.csv")
print("applications.csv")
print("assessments.csv")
print("interviews.csv")
print("offers.csv")