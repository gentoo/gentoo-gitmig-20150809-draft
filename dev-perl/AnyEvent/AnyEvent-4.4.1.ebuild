# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AnyEvent/AnyEvent-4.4.1.ebuild,v 1.1 2009/05/14 10:11:10 tove Exp $

EPI=2

inherit versionator

MODULE_AUTHOR=MLEHMANN
MY_P=${PN}-"$(get_major_version).$(delete_all_version_separators $(get_after_major_version))"
S=${WORKDIR}/${MY_P}

inherit perl-module

DESCRIPTION="provide framework for multiple event loops"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Event"
DEPEND=""

SRC_TEST="do"
