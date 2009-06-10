# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Event-Recurrence/DateTime-Event-Recurrence-0.16.ebuild,v 1.2 2009/06/10 12:43:58 tove Exp $

EAPI=2

MODULE_AUTHOR=FGLOCK
inherit perl-module

DESCRIPTION="DateTime::Set extension for create basic recurrence sets"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/DateTime
	dev-perl/DateTime-Set"
DEPEND="${RDEPEND}"

SRC_TEST=do
