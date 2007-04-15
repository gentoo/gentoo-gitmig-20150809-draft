
#
#
# Created by Daniel Black <dragonheart@gentoo.org> for the l7-filter projects
#

AC_INIT(l7-filter-userspace, [0.4], [http://sourceforge.net/tracker/?group_id=80085])
AC_PREREQ(2.60)

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE
AC_CONFIG_HEADERS(config.h)

#AC_PROG_CC
AC_PROG_CXX

PKG_CHECK_MODULES([NFNETLINK], [libnetfilter_conntrack libnetfilter_queue])
AC_CHECK_LIB(pthread, main)
AC_OUTPUT([Makefile])
