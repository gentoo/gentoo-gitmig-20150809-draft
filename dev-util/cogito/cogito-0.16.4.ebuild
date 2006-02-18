# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cogito/cogito-0.16.4.ebuild,v 1.8 2006/02/18 12:18:21 blubb Exp $

inherit eutils

MY_P=${P//_/}

DESCRIPTION="The GIT scripted toolkit"
HOMEPAGE="http://kernel.org/pub/software/scm/cogito/"
SRC_URI="http://kernel.org/pub/software/scm/cogito/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"
IUSE="doc"

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=dev-util/git-0.99.9
	doc? ( >=app-text/asciidoc-7.0.1 app-text/xmlto )"

RDEPEND="net-misc/rsync
		app-text/rcs
		net-misc/curl"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}

	# t9300-seek won't work
	rm t/t9300-seek.sh
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		sed -i -e "/^docdir=/s:cogito:${PF}:" \
			${S}/Documentation/Makefile || die "sed failed (Documentation)"
		emake -C Documentation || die "make documentation failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" prefix="/usr" || die "install failed"
	dodoc README* VERSION COPYING

	if use doc ; then
		doman Documentation/*.1 Documentation/*.7
		dodir /usr/share/doc/${PF}/html
		cp Documentation/*.html ${D}/usr/share/doc/${PF}/html/
	fi

	dodir /usr/share/doc/${PF}/contrib
	cp ${S}/contrib/* ${D}/usr/share/doc/${PF}/contrib
}
