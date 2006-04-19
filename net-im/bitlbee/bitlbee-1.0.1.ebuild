# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-1.0.1.ebuild,v 1.5 2006/04/19 12:48:35 tcort Exp $

inherit eutils toolchain-funcs

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz
		 msnextras? ( mirror://gentoo/${P}-msn6.akke.patch )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc sparc ~x86"
IUSE="debug jabber msn oscar yahoo gnutls openssl msnextras"

DEPEND=">=dev-libs/glib-2.0
	msn? ( gnutls? ( net-libs/gnutls )
		   openssl? ( dev-libs/openssl ) )
	jabber? ( gnutls? ( net-libs/gnutls )
			  openssl? ( dev-libs/openssl ) )"

no_flags_die() {
	eerror ""
	eerror "Please choose a protocol or protocols to use with"
	eerror "bitlbee by enabling the useflag for the protocol"
	eerror "desired."
	eerror ""
	eerror " Valid useflags are;"
	eerror " jabber, msn, oscar and yahoo"
	die "No IM protocols selected!"
}

pkg_setup() {
	einfo "Note: as of bitlbee-0.82-r1, all protocols are useflags."
	einfo "      Make sure you've enabled the flags you want."
	einfo ""
	einfo "To use jabber over SSL or MSN Messenger, you will need to enable"
	einfo "either the gnutls or openssl useflags."

	if use msnextras; then
		einfo ""
		einfo "NOTE: This is a patch for extra MSN functionality that is NOT"
		einfo "      supported by upstream.  Please do not report any problems"
		einfo "      to them about this as they will be ignored."
	fi

	use jabber || use msn || use oscar || use yahoo || no_flags_die
}

src_unpack() {
	unpack ${P}.tar.gz

	# Patch the default xinetd file to add/adjust values to Gentoo defaults
	cd ${S}/doc && epatch ${FILESDIR}/${PN}-1.0-xinetd.patch
	cd ${S} && epatch ${FILESDIR}/${PN}-gentoohack.patch

	if use msnextras; then
		epatch ${DISTDIR}/${P}-msn6.akke.patch
	fi
}

src_compile() {
	# setup useflags
	local myconf
	use debug && myconf="${myconf} --debug=1"
	use msn || myconf="${myconf} --msn=0 "
	use jabber || myconf="${myconf} --jabber=0"
	use oscar || myconf="${myconf} --oscar=0"
	use yahoo || myconf="${myconf} --yahoo=0"
	use gnutls && myconf="${myconf} --ssl=gnutls"
	use openssl && myconf="${myconf} --ssl=openssl"

	if ( ( use jabber && ( use gnutls || use openssl ) ) || use msn ) && \
	use !gnutls && use !openssl; then
		myconf="${myconf} --ssl=bogus"
	fi

	# NOTE: bitlbee's configure script is not an autotool creation, so that is
	# why we don't use econf.

	./configure --prefix=/usr --datadir=/usr/share/bitlbee \
		--etcdir=/etc/bitlbee ${myconf} || die "econf failed"

	emake || die "make failed"

	# make bitlbeed forking server
	cd utils
	$(tc-getCC) ${CFLAGS} bitlbeed.c -o bitlbeed || die "bitlbeed failed to compile"
}

src_install() {
	dodir /var/lib/bitlbee
	make install DESTDIR=${D} || die "install failed"
	make install-etc DESTDIR=${D} || die "install failed"
	make install-doc DESTDIR=${D} || die "install failed"
	keepdir /var/lib/bitlbee

	dodoc doc/{AUTHORS,CHANGES,CREDITS,FAQ,README}
	dodoc doc/user-guide/user-guide.txt
	dohtml -A xml doc/user-guide/*.xml
	dohtml -A xsl doc/user-guide/*.xsl
	dohtml doc/user-guide/*.html

	doman doc/bitlbee.8 doc/bitlbee.conf.5

	dobin utils/bitlbeed

	insinto /etc/xinetd.d
	newins doc/bitlbee.xinetd bitlbee

	exeinto /etc/init.d
	newexe ${FILESDIR}/bitlbeed.init bitlbeed || die

	insinto /etc/conf.d
	newins ${FILESDIR}/bitlbeed.confd bitlbeed || die

	dodir /var/run/bitlbeed
	keepdir /var/run/bitlbeed

	dodir /usr/share/bitlbee
	cp ${S}/utils/* ${D}/usr/share/bitlbee
	rm ${D}/usr/share/bitlbee/bitlbeed*
}

pkg_postinst() {
	chown nobody:nobody ${ROOT}/var/lib/bitlbee
	chmod 700 ${ROOT}/var/lib/bitlbee
	einfo "The utils included in bitlbee (other than bitlbeed) are now"
	einfo "located in /usr/share/bitlbee"
	einfo
	einfo "NOTE: The IRSSI script are no longer provided by BitlBee."
}
