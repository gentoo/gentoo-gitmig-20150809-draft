# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Builder/Mail-Builder-1.16.ebuild,v 1.2 2010/07/16 13:54:23 dev-zero Exp $

EAPI="3"

MODULE_AUTHOR="MAROS"

inherit perl-module

DESCRIPTION="Easily create plaintext/html e-mail messages with attachments and inline images"
HOMEPAGE="http://search.cpan.org/~maros/Mail-Builder"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

SRC_TEST="do"

COMMON="|| ( >=dev-lang/perl-5.10.1 ( perl-core/version perl-core/parent ) )
	dev-perl/MIME-tools
	dev-perl/Class-Accessor
	dev-perl/HTML-Tree
	dev-perl/MIME-Types
	>=dev-perl/Email-MessageID-1.40.1
	dev-perl/Text-Table
	dev-perl/IO-stringy"
DEPEND="${COMMON}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
RDEPEND="${COMMON}"

PATCHES=("${FILESDIR}/${PV}-escape-at-for-perl-5.8.patch")
src_install() {
	mydoc="Changes README"
	perl-module_src_install

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins example/*.pl
	fi
}
