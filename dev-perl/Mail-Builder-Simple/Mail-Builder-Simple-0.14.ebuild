# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Builder-Simple/Mail-Builder-Simple-0.14.ebuild,v 1.1 2010/07/15 08:03:06 dev-zero Exp $

EAPI="3"

MODULE_AUTHOR="TEDDY"

inherit perl-module

DESCRIPTION="Send UTF-8 HTML and text email using templates"
HOMEPAGE="http://search.cpan.org/~teddy/Mail-Builder-Simple"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

SRC_TEST="do"

COMMON="dev-lang/perl
	>=dev-perl/Mail-Builder-1.12
	dev-perl/Email-Sender
	dev-perl/Email-Valid
	dev-perl/Config-Any
	dev-perl/config-general
	>=dev-perl/MailTools-2.04
	dev-perl/Email-MessageID
	dev-perl/MIME-tools"
DEPEND="${COMMON}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
RDEPEND="${COMMON}"

src_install() {
	mydoc="Changes"
	perl-module_src_install
}
