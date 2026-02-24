/*
Project: Factors that Fuel Student Performance (DataCamp)
8/

-- ============================================================
-- 1) avg_exam_score_by_study_and_extracurricular
-- ============================================================

/*
Goal:
Analyze how studying more than 10 hours per week, while also participating in extracurricular activities, impacts exam performance.

Output:
- hours_studied
- avg_exam_score
*/


SELECT
	hours_studied,
	AVG(exam_score) AS avg_exam_score
FROM student_performance
WHERE extracurricular_activities = 'Yes'
	AND hours_studied > 10
GROUP BY hours_studied
ORDER BY hours_studied DESC;

-- ============================================================
-- 2) avg_exam_score_by_hours_studied_range
-- ============================================================

/*
Goal:
Explore how different ranges of study hours impact exam performance by calculating the average exam score for each study range.

Output:
- hours_studied_range
- avg_exam_score
*/

SELECT
	CASE
		WHEN hours_studied BETWEEN 1 AND 5 THEN '1-5 hours'
		WHEN hours_studied BETWEEN 6 AND 10 THEN '6-10 hours'
		WHEN hours_studied BETWEEN 11 AND 15 THEN '11-15 hours'
		WHEN hours_studied >= 16 THEN '16+ hours'
		ELSE 'unknown'
	END AS hours_studied_range,
	AVG(exam_score) AS avg_exam_score
FROM student_performance
GROUP BY hours_studied_range
ORDER BY avg_exam_score DESC;

-- ============================================================
-- 3) student_exam_ranking
-- ============================================================

/*
Goal:
Rank students relative to their peers without revealing individual exam scores.

Output:
- attendance
- hours_studied
- sleep_hours
- tutoring_sessions
*/

SELECT
	attendance,
	hours_studied,
	sleep_hours,
	tutoring_sessions,
	DENSE_RANK() OVER(ORDER BY exam_score DESC) AS exam_rank
FROM student_performance
ORDER BY exam_rank ASC
LIMIT 30;