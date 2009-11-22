# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libwww-perl/libwww-perl-5.834.ebuild,v 1.1 2009/11/22 10:49:57 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=GAAS
inherit perl-module

DESCRIPTION="A collection of Perl Modules for the WWW"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="ssl"

DEPEND="virtual/perl-libnet
	>=dev-perl/HTML-Parser-3.34
	>=dev-perl/URI-1.10
	>=virtual/perl-Digest-MD5-2.12
	dev-perl/HTML-Tree
	>=virtual/perl-MIME-Base64-2.12
	>=virtual/perl-IO-Compress-1.10
	ssl? ( dev-perl/Crypt-SSLeay )"
RDEPEND="${DEPEND}"

src_install() {
	perl-module_src_install
	dosym /usr/bin/lwp-request /usr/bin/GET
	dosym /usr/bin/lwp-request /usr/bin/POST
	dosym /usr/bin/lwp-request /usr/bin/HEAD
}
#SRC_TEST=do
