# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.40 2003/04/27 13:49:00 danarmak Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This is the kde-dist eclass for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# Don't use it for e.g. kdevelop, koffice because of their separate versionnig schemes.

inherit kde
ECLASS=kde-dist
INHERITED="$INHERITED $ECLASS"

# kde 3.1 prereleases have tarball versions of 3.0.6 ff
unset SRC_URI
case "$PV" in
	1*)				SRC_PATH="stable/3.0.2/src/${P}.tar.bz2";; # backward compatibility for unmerging ebuilds
	2.2.2a)			SRC_PATH="2.2.2/src/${PN}-${PV/a/}.tar.bz2" ;;
	2.2.2*)			SRC_PATH="2.2.2/src/${P}.tar.bz2" ;;
	3.1_alpha1)		SRC_PATH="unstable/kde-3.1-alpha1/src/${P//3.1_alpha1/3.0.6}.tar.bz2" ;;
	3.1_beta1)		SRC_PATH="unstable/kde-3.1-beta1/src/${P//3.1_beta1/3.0.7}.tar.bz2" ;;
	3.1_beta2)		SRC_PATH="unstable/kde-3.1-beta2/src/${P//3.1_beta2/3.0.8}.tar.bz2" ;;
	3.1_rc1)		SRC_PATH="unstable/kde-3.1-rc1/src/${P//3.1_rc1/3.0.9}.tar.bz2" ;;
	3.1_rc2)		SRC_PATH="unstable/kde-3.1-rc2/src/${P//3.1_rc2/3.0.98}.tar.bz2" ;;
	3.1_rc3)		SRC_PATH="unstable/kde-3.1-rc3/src/${P//3.1_rc3/3.0.99}.tar.bz2" ;;
	3.1_rc5)		SRC_PATH="unstable/kde-3.1-rc5/src/${P//_}.tar.bz2" ;;
	3.1_rc6)		SRC_PATH="unstable/kde-3.1-rc6/src/${P//_}.tar.bz2" ;;
	3.1.1a)			SRC_PATH="stable/$PV/src/${PN}-3.1.1.tar.bz2"
				SRC_URI="$SRC_URI mirror://gentoo/${PN}-${PVR}.diff.bz2" ;;
	3*)			SRC_PATH="stable/$PV/src/${P}.tar.bz2" ;;
	5)					SRC_URI="" # cvs ebuilds, no SRC_URI needed
		debug-print "$ECLASS: cvs detected" ;;
	*)		debug-print "$ECLASS: Error: unrecognized version $PV, could not set SRC_URI" ;;
esac
[ -n "$SRC_PATH" ] && SRC_URI="$SRC_URI mirror://kde/$SRC_PATH"
debug-print "$ECLASS: finished, SRC_URI=$SRC_URI"

need-kde $PV

# 3.1 prereleases
[ "$PV" == "3.1_alpha1" ] && S=${WORKDIR}/${PN}-3.0.6
[ "$PV" == "3.1_beta1" ] && S=${WORKDIR}/${PN}-3.0.7
[ "$PV" == "3.1_beta2" ] && S=${WORKDIR}/${PN}-3.0.8
[ "$PV" == "3.1_rc1" ] && S=${WORKDIR}/${PN}-3.0.9
[ "$PV" == "3.1_rc2" ] && S=${WORKDIR}/${PN}-3.0.98
[ "$PV" == "3.1_rc3" ] && S=${WORKDIR}/${PN}-3.0.99
[ "$PV" == "3.1_rc5" ] && S=${WORKDIR}/${PN}-3.1rc5
[ "$PV" == "3.1_rc6" ] && S=${WORKDIR}/${PN}-3.1rc6

# these use incrememntal patches so as to avoid downloadnig a lot of stuff all over
if [ "$PV" == "3.1.1a" ]; then
    PATCHES1="${WORKDIR}/${PN}-${PVR}.diff"
    export S="${WORKDIR}/${PN}-3.1.1"
fi

DESCRIPTION="KDE ${PV} - "
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"

SLOT="$KDEMAJORVER.$KDEMINORVER"

debug-print "----------- $ECLASS finished -----------------"
