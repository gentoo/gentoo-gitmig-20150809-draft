# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/atheme/atheme-0.2.2.ebuild,v 1.2 2005/11/10 18:19:09 gustavoz Exp $

inherit eutils

DESCRIPTION="A portable, secure set of open source, and modular IRC services"
HOMEPAGE="http://atheme.org/"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="largenet postgres"

DEPEND=">=sys-devel/autoconf-2.59"
RDEPEND="postgres? ( dev-db/postgresql )"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S} || die "cd '${S}' failed"

	epatch ${FILESDIR}/make-postgresql-support-optional.patch \
		|| die "epacth failed"
	epatch ${FILESDIR}/makefile-DESTDIR-support.patch \
		|| die "epatch failed"
}

src_compile() {
	autoreconf -i || die "autoreconf failed"
	./configure \
		--prefix=/var/lib/atheme \
		`use_with postgresql` \
		`use_with largenet large-net` \
		|| die "configure failed"

	make DESTDIR="${D}" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"
	cp "${D}"/var/lib/atheme/etc/{example,atheme}.conf || die "cp failed"
	dodoc ChangeLog INSTALL README || die "dodoc failed"
	dodoc doc/{example_module.c,LICENSE,POSTGRESQL,RELEASE,ROADMAP} \
		|| die "dodoc failed"
	rm -rf "${D}"/var/lib/atheme/doc
}

pkg_postinst() {
	einfo
	einfo "Don't forget to edit /var/lib/atheme/etc/atheme.conf!"
	einfo
}
