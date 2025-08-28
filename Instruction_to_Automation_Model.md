# GitHub Copilot Prompt: Automate Test Execution with Jira MCP and Oracle SQLcl MCP and Github MCP server.

You are tasked with building a full automation pipeline using two MCP servers: **Jira MCP** ,  **Oracle SQLcl MCP** and **Github MCP server**., along with Unix server execution using Paramiko. Follow these steps exactly and **do not stop** until all steps and test cases are completed.

---

## Step 1. Create Manual test cases from User story

- From the file:  
  `User_story_01.txt` Which is present in current folder.
  
- Extract  All imformation from the User_story_01.txt file.

- Create Test cases and cover all things.

---

## Step 2. Jira MCP Server – Create User Story

- Use **Jira MCP server** to:
  - Create one jira issue And give name :'DMSING106',In project: `XSP`.Don't create separate issue for each Test case.

  - Add each test scenario under Same 'DMSING106' issue as its Subtask.
  And link it to "DMSING106"
  - Subtask items names should be Number_ and then Description
  - And in each Subtask items GIve Steps which we have to follow. As step 1 then step 2.
  - Then Write Expected Output also.


---

## Step 3. Unix Test Cases – Paramiko Automation

Only if all Unix job statuses are **Success**, proceed to SQL testing.

- Create a PowerShell script `run_unix_job_status.ps1` to:
  - Import all credentials from `.env` file which is present in current filder "DATA_28_8".only take credential from this file which is present here And not from other env.
  - Run the remote script already present on the Unix server (e.g., `/home/kiranmote/job_status_example.sh`).
  - Capture and show all job statuses.

Run or execute the created `run_unix_job_status.ps1` script. Print status. If all are success, then proceed to Step 4.


---

## Step 4. SQLcl MCP – Execute Test Cases

- For each SQL-related test case:
  - Use SQLcl MCP.
  - Execute the test case.
  - Capture the results and pass/fail status.
  
---


## Step 5. HTML Report – Generate

- Use **HTML** to:
  - Generate an HTML test report from execution results.
  - Save it in `html-report/` directory.

---
## Step 6. Jira MCP – Update 

- Using **Jira MCP server**:
  - Update `DMSING106`and its All Sub-Tasks also based on final test execution status.
  - Include pass/fail Detailed summary in the Story and sub-task description and in respective comments. And mention Local run Result.

## Step 7. Github MCP – Push all Automation test Scripts

- Using **Github MCP server**:
  - Make new repo with name Unix_Data_Automation_01.
  - push all Created automation test script in that repo.
  -Don't push .env.

---
## ❗ Final Notes

- Automate everything in sequence — from `.txt` extraction to final Pushing code in Github new repo.
- Don’t stop until all test cases are handled.
- Don't Stop untill all work is done.
- Clearly separate SQL and Unix test execution logic.
- Use clean logging and error handling.
- Maintain modular code (functions/scripts).
