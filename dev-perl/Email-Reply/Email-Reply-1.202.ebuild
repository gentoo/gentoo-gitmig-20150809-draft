# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Reply/Email-Reply-1.202.ebuild,v 1.10 2010/02/25 07:40:38 tove Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Reply to a Message"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-perl/Email-Abstract-2.13.1
	>=dev-perl/Email-MIME-1.900
	dev-perl/Email-Address"
DEPEND="${RDEPEND}"

SRC_TEST="do"
