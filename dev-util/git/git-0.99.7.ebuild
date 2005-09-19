# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/git/git-0.99.7.ebuild,v 1.1 2005/09/19 14:45:46 r3pek Exp $

DESCRIPTION="GIT - the stupid content tracker"
HOMEPAGE="http://kernel.org/pub/software/scm/git/"
SRC_URI="http://kernel.org/pub/software/scm/git/${PN}-core-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="mozsha1 ppcsha1 doc nocurl"
S="${WORKDIR}/${PN}-core-${PV}"

DEPEND="dev-libs/openssl
		sys-libs/zlib
		!nocurl? ( net-misc/curl )
		app-text/rcs
		>=dev-util/cvsps-2.1
		!app-misc/git
		doc? ( >=app-text/asciidoc-7.0.1 app-text/xmlto )"

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
	elif use nocurl; then
		export NO_CURL=yes
		ewarn "git-http-pull will not be built because you are using the nocurl
			use flag"
	fi

	make prefix=/usr || die "make failed"

	if use doc; then
		cd ${S}/Documentation
		make || die "make documentation failed"
	fi
}

src_install() {
	make DESTDIR=${D} prefix=/usr install || die "make install failed"
	dodoc README COPYING

	if use doc; then
		doman Documentation/*.1 Documentation/*.7
	fi
}

pkg_postinst() {
	einfo
	einfo "This version of GIT has changed some command names. It this version"
	einfo "The old commands will still be present but linked to the new ones."
	einfo "The future 0.99.8 version of GIT will NOT have this feature."
	einfo
	einfo "For the complete list of commands that got changed, visist:"
	einfo "http://dev.gentoo.org/~r3pek/git-new-command-list.txt"
	einfo
}
