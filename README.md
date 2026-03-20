# Digital Service Failure Analysis

## Overview
This project analyzes digital service failures using SQL by simulating a real-world service-based system. It focuses on identifying failure patterns, service downtime, and performance issues across multiple services and teams.

## Objectives
- Analyze failure trends across different services
- Identify peak failure time periods
- Measure service downtime during incidents
- Understand failure distribution by teams and user locations

## Tools & Technologies
- SQL (MySQL)

## Database Structure
The project consists of the following tables:

- **services** → Stores service details and responsible teams  
- **users** → Contains user information and locations  
- **service_logs** → Records all service events (success/failure)  
- **incidents** → Tracks service downtime incidents  
- **incident_users** → Maps affected users to incidents  

## Key Analysis Performed

### 1. Failure Count by Service
- Identifies which services have the highest failure rates

### 2. Failure Count by Team
- Determines which teams are responsible for most failures

### 3. Peak Failure Hours
- Analyzes time-based trends to find when failures occur most frequently

### 4. Service Downtime Analysis
- Calculates downtime (in minutes) for each incident using timestamps

### 5. Success vs Failure Comparison
- Compares total successful and failed events

### 6. Failures by User Location
- Identifies cities with higher failure occurrences

## Dataset Details
The dataset is manually created and includes:
- Service operations (Login, Payment, Order, Notification)
- Failure reasons (e.g., timeout, server down, invalid credentials)
- Timestamps for tracking real-time events
- Incident records with downtime duration

## Key Insights
- Payment and Order services show higher failure rates during peak hours  
- Most failures occur during evening time (high system load)  
- Certain incidents caused significant downtime impacting multiple users  
- Failures are distributed across different cities, indicating system-wide issues  

## How to Run the Project
1. Create a database in MySQL
2. Run the provided SQL script file:
   ```sql
   Digital_Service_Failure_Analysis.sql
