# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kde-dist.eclass,v 1.39 2003/04/11 16:08:54 hannes Exp $
#
# Author Dan Armak <danarmak@gentoo.org>
#
# This is the kde-dist eclass for >=2.2.1 kde base packages. Don't use for kdelibs though :-)
# Don't use it for e.g. kdevelop, koffice because of their separate versionnig schemes.

inherit kde-base kde.org
ECLASS=kde-dist
INHERITED="$INHERITED $ECLASS"

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


