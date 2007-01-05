# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/debug.eclass,v 1.32 2007/01/05 04:11:01 antarus Exp $

# STOP USING THIS ECLASS
# It was broken, and debug useflag should _not_ touch CFLAGS to start with.
# See http://bugs.gentoo.org/show_bug.cgi?id=55708 for info about this
# and http://www.gentoo.org/proj/en/qa/backtraces.xml to learn how to get
# a debug build.
case "$EBUILD_PHASE" in
	setup)
		ewarn "QA Notice: The package ${PF} still uses the broken debug.eclass"
	;;
	*)
	;;
esac
