# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/colordiff/colordiff-1.0.9.ebuild,v 1.6 2009/11/24 17:01:58 darkside Exp $

EAPI=2
inherit prefix

DESCRIPTION="Colorizes output of diff"
HOMEPAGE="http://colordiff.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
# Hasn't been copied to mirrors yet
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ~mips ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/diffutils"

src_prepare() {
	# set proper etcdir for Gentoo Prefix
	sed -i -e "s:'/etc:'@GENTOO_PORTAGE_EPREFIX@/etc:" "${S}/colordiff.pl" \
		|| die "sed etcdir failed"
	eprefixify ${S}/colordiff.pl
}

# This package has a makefile, but we don't want to run it
src_compile() { :; }

src_install() {
	newbin colordiff.pl colordiff || die
	newbin cdiff.sh cdiff || die
	insinto /etc
	doins colordiffrc colordiffrc-lightbg || die
	dodoc BUGS CHANGES README TODO || die
	doman {cdiff,colordiff}.1 || die
}
