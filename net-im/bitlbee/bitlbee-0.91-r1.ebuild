# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/bitlbee/bitlbee-0.91-r1.ebuild,v 1.1 2004/11/24 02:30:35 weeve Exp $

inherit eutils gcc

DESCRIPTION="irc to IM gateway that support multiple IM protocols"
HOMEPAGE="http://www.bitlbee.org/"
SRC_URI="http://get.bitlbee.org/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~ia64 ~amd64"
IUSE="debug jabber msn oscar yahoo flood ssl"

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	msn? ( net-libs/gnutls )
	jabber? ( ssl? ( net-libs/gnutls ) )"

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

	use jabber || use msn || use oscar || use yahoo || no_flags_die
}

src_unpack() {
	unpack ${P}.tar.gz

	# Patch the default xinetd file to add/adjust values to Gentoo defaults
	cd ${S}/doc && epatch ${FILESDIR}/${PN}-0.80-xinetd.patch
}

src_compile() {
	# setup useflags
	local myconf
	use debug && myconf="${myconf} --debug=1"
	use msn || myconf="${myconf} --msn=0 "
	use jabber || myconf="${myconf} --jabber=0"
	use oscar || myconf="${myconf} --oscar=0"
	use yahoo || myconf="${myconf} --yahoo=0"
	use flood && myconf="${myconf} --flood=1"

	if ( ( use jabber && use ssl ) || use msn ); then
		myconf="--ssl=gnutls"
	else
		myconf="--ssl=bogus"
	fi

	econf --datadir=/usr/share/bitlbee --etcdir=/etc/bitlbee ${myconf} \
		|| die "econf failed"

	emake || die "make failed"

	# make bitlbeed forking server
	cd utils
	$(gcc-getCC) ${CFLAGS} bitlbeed.c -o bitlbeed || die "bitlbeed failed to compile"
}

src_install() {
	dodir /var/lib/bitlbee
	make install DESTDIR=${D} || die "install failed"
	make install-etc DESTDIR=${D} || die "install failed"
	make install-doc DESTDIR=${D} || die "install failed"
	keepdir /var/lib/bitlbee

	dodoc doc/{AUTHORS,CHANGES,CREDITS,FAQ,README,TODO,user-guide.txt}
	dohtml -A sgml doc/*.sgml
	dohtml -A xml doc/*.xml
	dohtml -A xsl doc/*.xsl
	dohtml doc/*.html

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

	has_version net-irc/irssi && [ -d /usr/share/irssi/scripts ] && \
		dodir /usr/share/irssi/scripts && \
		dosym /usr/share/bitlbee/bitlbee_tab_completion.pl \
			/usr/share/irssi/scripts/bitlbee_tab_completion.pl

}

pkg_postinst() {
	chown nobody:nobody ${ROOT}/var/lib/bitlbee
	chmod 700 ${ROOT}/var/lib/bitlbee
	einfo "The utils included in bitlbee (other than bitlbeed) are now"
	einfo "located in /usr/share/bitlbee"
}
