# Created by Daniel Black <dragonheart@gentoo.org> for the l7-filter projects
#
EXTRA_DIST = sample-l7-filter.conf

bin_PROGRAMS = l7-filter

AM_CXXFLAGS = $(NFNETLINK_CFLAGS)

l7_filter_SOURCES = l7-classify.cpp l7-queue.cpp l7-conntrack.cpp  l7-filter.cpp l7-parse-patterns.cpp  util.cpp
l7_filter_LDADD = $(NFNETLINK_LIBS)
#-lpthread

dist_man_MANS = l7-filter.1
