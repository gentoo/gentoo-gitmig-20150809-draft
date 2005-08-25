# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-0.99.4.ebuild,v 1.2 2005/08/25 09:56:33 r3pek Exp $

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://kernel.org/pub/software/scm/git/"
SRC_URI="http://kernel.org/pub/software/scm/git/${PN}-core-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="mozsha1 ppcsha1 doc"

DEPEND="dev-libs/openssl
		sys-libs/zlib
		net-misc/curl
		!app-misc/git
		doc? ( >=app-text/asciidoc-7.0.1 app-text/xmlto )"
S="${WORKDIR}/${PN}-core-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:-g -O2:${CFLAGS}:" \
		Makefile
}

src_compile() {
	if use mozsha1; then
		export MOZILLA_SHA1=yes
	elif use ppcsha1; then
		export PPC_SHA1=yes
	fi

	make prefix=/usr || die "make failed"

	if use doc; then
		cd ${S}/Documentation
		make || die "make documentation failed"
	fi
}

src_install() {
	make dest=${D} prefix=/usr install || die "make install failed"
	dodoc README COPYING

	if use doc; then
		doman Documentation/*.1 Documentation/*.7
	fi
}
