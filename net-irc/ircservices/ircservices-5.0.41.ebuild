# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircservices/ircservices-5.0.41.ebuild,v 1.3 2004/10/24 21:09:03 swegener Exp $

inherit eutils fixheadtails flag-o-matic

DESCRIPTION="ChanServ, NickServ & MemoServ with support for several IRC daemons"
HOMEPAGE="http://www.ircservices.za.net/"
SRC_URI="ftp://ftp.esper.net/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

# configure fails with -O higher than 2
replace-flags "-O[3-9]" "-O2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/5.0.37-fPIC.patch

	ht_fix_file configure
}

src_compile() {
	./configure \
		-cflags "${CFLAGS}" \
		-bindest /usr/bin \
		-datdest /var/lib/ircservices \
		|| die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	dodir \
		/usr/bin \
		/{etc,{usr,var}/lib,usr/share}/ircservices
	keepdir /var/log/ircservices
	fperms 700 /{etc,var/lib}/ircservices

	make \
		BINDEST=${D}/usr/bin \
		DATDEST=${D}/var/lib/ircservices \
		install \
		|| die "make install failed"

	mv ${D}/var/lib/ircservices/convert-db \
		${D}/usr/bin/ircservices-convert-db

	# Now we move some files around to make it FHS conform
	mv ${D}/var/lib/ircservices/example-ircservices.conf \
		${D}/etc/ircservices/ircservices.conf
	dosym /etc/ircservices/ircservices.conf \
		/var/lib/ircservices/ircservices.conf

	mv ${D}/var/lib/ircservices/example-modules.conf \
		${D}/etc/ircservices/modules.conf
	dosym /etc/ircservices/modules.conf /var/lib/ircservices/modules.conf

	mv ${D}/var/lib/ircservices/modules ${D}/usr/lib/ircservices
	dosym /usr/lib/ircservices/modules /var/lib/ircservices/modules

	mv ${D}/var/lib/ircservices/{helpfiles,languages} \
		${D}/usr/share/ircservices
	dosym /usr/share/ircservices/helpfiles /var/lib/ircservices/helpfiles
	dosym /usr/share/ircservices/languages /var/lib/ircservices/languages

	exeinto /etc/init.d
	newexe ${FILESDIR}/ircservices.init.d ircservices
	insinto /etc/conf.d
	newins ${FILESDIR}/ircservices.conf.d ircservices

	doman docs/ircservices.8
	newman docs/convert-db.8 ircservices-convert-db.8
	dohtml docs/*.html
	dodoc KnownBugs Changes README TODO WhatsNew
}

pkg_postinst() {
	enewuser ircservices
	chown ircservices ${ROOT}/var/lib/ircservices
	chown -R ircservices ${ROOT}/etc/ircservices
}
