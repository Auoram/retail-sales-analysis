# Data Cleaning Log

**Project:** Retail Sales Analysis
**Dataset:** Sample Superstore
**Tool Used:** Microsoft Excel Power Query

## Summary

The dataset was reviewed and cleaned using Power Query before being imported into SQLite for SQL analysis. The objective was to ensure consistent data types, improve data quality, and prepare the dataset for reliable querying and visualization.

---

## Cleaning Actions Performed

### 1. Date Conversion

* Converted the **Order Date** and **Ship Date** columns from text to the **Date** data type using the **English (United States)** locale to correctly interpret the original `MM/DD/YYYY` format.
** Reformatted both columns to the ISO standard YYYY-MM-DD before exporting the cleaned dataset for SQLite compatibility.

---

### 2. Duplicate Check

* Checked the dataset for duplicate records using Power Query's **Remove Duplicates** feature across all columns.
* **Rows before cleaning:** 9,994
* **Rows after duplicate check:** 9,994
* **Duplicate rows removed:** 0

No exact duplicate records were found.

---

### 3. Missing Values

* Reviewed the dataset for missing values, with particular attention to the **Postal Code** column.
* Missing postal codes were retained because the remaining location information (such as **City**, **State**, and **Region**) remained available for analysis, avoiding unnecessary data loss.

---

### 4. Text Cleaning

* Applied **Trim** to remove leading and trailing spaces from text fields.
* Applied **Clean** to remove non-printable characters.
* Reviewed text columns for inconsistent capitalization. No significant formatting inconsistencies requiring correction were identified.

---

## Output

The cleaned dataset was exported as:

`data/cleaned/superstore_cleaned.csv`

The original raw dataset was preserved unchanged in:

`data/raw/Sample - Superstore.csv`

The Power Query workbook containing all transformation steps was saved as:

`working/superstore_cleaning.xlsx`

---

## Result

The dataset is now prepared for SQL analysis in SQLite and subsequent visualization in Power BI.
