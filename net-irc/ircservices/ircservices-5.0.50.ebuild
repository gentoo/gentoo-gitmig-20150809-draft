# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircservices/ircservices-5.0.50.ebuild,v 1.1 2005/04/02 17:14:56 swegener Exp $

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
replace-flags "-O[3-9s]" "-O2"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/5.0.37-fPIC.patch

	ht_fix_file configure
	sed -i -e "s/HEAD -1/HEAD -n 1/" configure
}

src_compile() {
	append-flags -fno-stack-protector

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
		/{etc,{usr,var}/lib,usr/share}/ircservices || die "dodir failed"
	keepdir /var/log/ircservices || die "keepdir failed"
	fperms 700 /{etc,var/lib}/ircservices || die "fperms failed"

	make \
		BINDEST=${D}/usr/bin \
		DATDEST=${D}/var/lib/ircservices \
		install \
		|| die "make install failed"

	mv ${D}/var/lib/ircservices/convert-db \
		${D}/usr/bin/ircservices-convert-db || die "mv failed"

	# Now we move some files around to make it FHS conform
	mv ${D}/var/lib/ircservices/example-ircservices.conf \
		${D}/etc/ircservices/ircservices.conf || die "mv failed"
	dosym /etc/ircservices/ircservices.conf \
		/var/lib/ircservices/ircservices.conf || die "dosym failed"

	mv ${D}/var/lib/ircservices/example-modules.conf \
		${D}/etc/ircservices/modules.conf || die "mv failed"
	dosym /etc/ircservices/modules.conf /var/lib/ircservices/modules.conf \
		|| die "dosym failed"

	mv ${D}/var/lib/ircservices/modules ${D}/usr/lib/ircservices \
		|| die "mv failed"
	dosym /usr/lib/ircservices/modules /var/lib/ircservices/modules \
		|| die "dosym failed"

	mv ${D}/var/lib/ircservices/{helpfiles,languages} \
		${D}/usr/share/ircservices  || die "mv failed"
	dosym /usr/share/ircservices/helpfiles /var/lib/ircservices/helpfiles \
		|| die "mv failed"
	dosym /usr/share/ircservices/languages /var/lib/ircservices/languages \
		|| die "dosym failed"

	newinitd ${FILESDIR}/ircservices.init.d ircservices \
		|| die "newinitd failed"
	newconfd ${FILESDIR}/ircservices.conf.d ircservices \
		|| die "newconfd failed"

	doman docs/ircservices.8 || die "doman failed"
	newman docs/convert-db.8 ircservices-convert-db.8 || die "newman failed"
	dohtml docs/*.html || die "dohtml failed"
	dodoc KnownBugs Changes README TODO WhatsNew || die "dodoc failed"
}

pkg_postinst() {
	enewuser ircservices
	chown ircservices ${ROOT}/var/lib/ircservices
	chown -R ircservices ${ROOT}/etc/ircservices
}
