/*
 * include/linux/low-latency.h
 *
 * Andrew Morton <andrewm@uow.edu.au>
 */

#ifndef LOW_LATENCY_H_INCLUDED
#define LOW_LATENCY_H_INCLUDED

#if defined(CONFIG_LOLAT)
#define LOWLATENCY_NEEDED	1
#else
#define LOWLATENCY_NEEDED	0
#endif

#if LOWLATENCY_NEEDED

#include <linux/cache.h>		/* For ____cacheline_aligned */

#ifdef CONFIG_LOLAT_SYSCTL
extern struct low_latency_enable_struct {
	int yep;
} ____cacheline_aligned __enable_lowlatency;
#define enable_lowlatency __enable_lowlatency.yep

#else
#define enable_lowlatency 1
#endif

/*
 * Set this non-zero to generate low-latency instrumentation
 */
#define LOWLATENCY_DEBUG		0

/*
 * Set this non-zero for robustness testing
 */
#define LOWLATENCY_ALWAYS_SCHEDULE	0

#if LOWLATENCY_DEBUG

#if LOWLATENCY_ALWAYS_SCHEDULE
#define conditional_schedule_needed() ((enable_lowlatency == 2) || (enable_lowlatency && current->need_resched))
#else
#define conditional_schedule_needed() (enable_lowlatency && current->need_resched)
#endif

struct lolat_stats_t {
	unsigned long count;
	int visited;
	const char *file;
	int line;
	struct lolat_stats_t *next;
};

void set_running_and_schedule(struct lolat_stats_t *stats);

#define unconditional_schedule()					\
	do {								\
		static struct lolat_stats_t stats = {			\
			file: __FILE__,					\
			line: __LINE__,					\
		};							\
		set_running_and_schedule(&stats);			\
	} while (0)

extern void show_lolat_stats(void);

#else	/* LOWLATENCY_DEBUG */

#if LOWLATENCY_ALWAYS_SCHEDULE
#define conditional_schedule_needed() 1
#else
#define conditional_schedule_needed() (current->need_resched)
#endif

void set_running_and_schedule(void);
#define unconditional_schedule() set_running_and_schedule()

#endif	/* LOWLATENCY_DEBUG */

#define DEFINE_RESCHED_COUNT	int resched_count = 0
#define TEST_RESCHED_COUNT(n)	(enable_lowlatency && (++resched_count > (n)))
#define RESET_RESCHED_COUNT()	resched_count = 0
extern int ll_copy_to_user(void *to_user, const void *from, unsigned long len);

#else	/* LOWLATENCY_NEEDED */

#define conditional_schedule_needed() 0
#define conditional_schedule()
#define unconditional_schedule()

#define DEFINE_RESCHED_COUNT
#define TEST_RESCHED_COUNT(n)	0
#define RESET_RESCHED_COUNT()
#define ll_copy_to_user(to_user, from, len) copy_to_user((to_user), (from), (len))

#endif	/* LOWLATENCY_NEEDED */

#endif /* LOW_LATENCY_H_INCLUDED */

