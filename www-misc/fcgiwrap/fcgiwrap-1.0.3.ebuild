# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/fcgiwrap/fcgiwrap-1.0.3.ebuild,v 1.5 2011/10/04 11:01:35 nativemad Exp $

EAPI="3"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git" || VCS_ECLASS=""
inherit autotools ${VCS_ECLASS}

DESCRIPTION="Simple FastCGI wrapper for CGI scripts (CGI support for nginx)"
HOMEPAGE="http://nginx.localdomain.pl/wiki/FcgiWrap"

LICENSE="BSD"
SLOT="0"
IUSE=""

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://github.com/gnosek/${PN}.git"

	KEYWORDS=""
else
	MY_REV="58ec209"
	#SRC_URI="http://download.github.com/gnosek-${P}-4-g${MY_REV}.tar.gz"
	SRC_URI="mirror://gentoo/gnosek-${P}-4-g${MY_REV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/gnosek-${PN}-${MY_REV}"

	KEYWORDS="amd64 x86"
fi

DEPEND="dev-libs/fcgi"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '/man8dir = $(DESTDIR)/s/@prefix@//' \
		-i Makefile.in || die "sed failed"

	eautoreconf
}

src_install() {
	einstall DESTDIR="${D}"

	dodoc README.rst
}

pkg_postinst() {
	einfo 'You may want to install www-servers/spawn-fcgi to use with fcgiwrap.'
}
