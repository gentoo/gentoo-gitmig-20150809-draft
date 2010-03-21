# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facter/facter-1.5.7-r1.ebuild,v 1.1 2010/03/21 07:53:04 hollow Exp $

EAPI="2"

inherit ruby

DESCRIPTION="A cross-platform Ruby library for retrieving facts from operating systems"
LICENSE="GPL-2"
HOMEPAGE="http://reductivelabs.com/projects/facter/index.html"
SRC_URI="http://reductivelabs.com/downloads/${PN}/${P}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"

USE_RUBY="ruby18"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.7-fqdn.patch
	epatch "${FILESDIR}"/${PN}-1.5.7-virtual.patch
}

src_compile() {
	:
}

src_install() {
	DESTDIR="${D}" ruby_einstall || die
	DESTDIR="${D}" erubydoc
}
