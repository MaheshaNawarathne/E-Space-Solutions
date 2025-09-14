 E-Space Solutions Mars Colonization Database

Project Overview
A comprehensive database management system designed for **E-Space Solutions (PVT) Ltd** to support humanity's first Mars colonization mission in 2040. This SQL Server database manages colonists, spacecraft, housing, job assignments, and mission logistics for the pioneering Mars settlement program.

 Key Features

- Colonist Management: Track colonist profiles, dependents, and personal details
- Spacecraft Operations: Manage E-Jet spacecraft and pilot assignments
- Mission Planning: Schedule and monitor trips to Mars
- Housing Allocation: Assign colony housing based on family size
- Job Management: Assign colonists to critical colony roles
- Role-Based Security: Secure access control with different permission levels

Database Schema

Main Entities
- Colonist: Primary colonist information and profiles
- Dependent: Family members and dependents of colonists
- E-Jet: Spacecraft specifications and details
- Pilot: Astronaut personnel and qualifications
- Trip: Mission schedules and logistics
- House: Mars colony housing units
- Job: Colonist job assignments and roles

Relationships
- One-to-Many: Colonist to Dependents
- Many-to-Many: Colonist to Jobs, Colonist to Trips
- One-to-Many: E-Jet to Trips, Pilot to E-Jet

Technologies Used

- Microsoft SQL Server 2019
- SQL Server Management Studio (SSMS)
- T-SQL for database programming
- Git for version control
- Entity-Relationship Diagram (ERD) for design documentation

Project Structure

```
espace-solutions-db/
├── database_schema.sql      # Complete database creation script
├── sample_data.sql          # Sample data insertion
├── queries.sql              # Business intelligence queries
├── documentation/           # ER diagrams and documentation
├── README.md               # Project documentation
└── .gitignore              # Git ignore rules
```

Installation & Setup

1. Clone the Repository
   ```bash
   git clone https://github.com/your-username/espace-solutions-database.git
   cd espace-solutions-database
   ```

2. Database Setup
   ```sql
   -- Execute in SQL Server Management Studio
   USE master;
   GO
   :r database_schema.sql
   :r sample_data.sql
   ```

3. Run Sample Queries
   ```sql
   USE ESpaceSolutions;
   GO
   :r queries.sql
   ```

Sample Queries

1. Colonist Demographic Report
```sql
SELECT colonists with their dependents count and housing details
```

2. Mission Capacity Planning
```sql
SELECT trip schedules with passenger counts and seat availability
```

3. Personnel Management
```sql
SELECT colonists with job assignments and qualifications
```

Security Features

- sa_user: Full database permissions with GRANT OPTION
- user1: SELECT-only permissions for read-only access
- Role-based access control implementation
- Transaction rollback demonstration for data protection

Business Value

This database system supports critical operations for:
- Colonist selection and management
- Mission planning and execution
- Resource allocation on Mars
- Housing and job assignment
- Reporting and decision support

Academic Context

Module: CIS5004 - Data and Knowledge Management  
Institution: Cardiff School of Technologies  
Purpose: Academic project demonstrating database design, normalization, and implementation

License

This project is created for academic purposes as part of Cardiff School of Technologies curriculum.

Developer

N. M. K. Maheshsa Nwarathne
- Student ID: KD/BSCSE-CMU/06/04, st20302355
- Module: CIS5004 Data and Knowledge Management
- Institution: Cardiff Metropolitan University (ICBT Kandy Campus)

"Building the database foundation for humanity's interplanetary future"
