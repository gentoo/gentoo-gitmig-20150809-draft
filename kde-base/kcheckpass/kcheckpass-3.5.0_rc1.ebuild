# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:24 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="pam"
DEPEND="pam? ( kde-base/kdebase-pam ) !pam? ( sys-apps/shadow )"

# Fixes problem with PIE and kcheckpass with --enable-final on PIC plaforms
# Already applied for 3.5 RC.
PATCHES="${FILESDIR}/${PN}-pie-final.patch"

