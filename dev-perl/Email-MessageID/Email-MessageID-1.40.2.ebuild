# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MessageID/Email-MessageID-1.40.2.ebuild,v 1.5 2010/11/13 19:37:16 armin76 Exp $

EAPI=3

inherit versionator
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Generate world unique message-ids"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86 ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Email-Address"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
