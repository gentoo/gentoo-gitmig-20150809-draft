# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircd-hybrid/ircd-hybrid-7.1.1.ebuild,v 1.1 2005/08/10 21:16:54 swegener Exp $

inherit eutils toolchain-funcs

# Additional configuration options
MAX_NICK_LENGTH=30
MAX_CLIENTS=512
MAX_TOPIC_LENGTH=390
ENABLE_SMALL_NETWORK=1
ENABLE_EFNET=0

IUSE="debug ssl static zlib"

DESCRIPTION="IRCD-Hybrid - High Performance Internet Relay Chat"
HOMEPAGE="http://ircd-hybrid.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"

RDEPEND="dev-libs/libelf
	zlib? ( >=sys-libs/zlib-1.1.4-r2 )
	ssl? ( >=dev-libs/openssl-0.9.7d )"

DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.4a-r5
	>=sys-devel/bison-1.875
	>=sys-devel/gettext-0.12.1"

pkg_setup() {
	enewgroup hybrid
	enewuser hybrid -1 -1 -1 hybrid
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/7.1.0-default-config.patch
}

src_compile() {
	local myconf=""

	ewarn
	ewarn "Server administrators are encouraged to customize some variables in"
	ewarn "the ebuild if actually deploying hybrid in an IRC network."
	ewarn "The values below reflect a usable configuration but may not be"
	ewarn "suitable for large networks in production environments."
	ewarn
	ewarn "To change the default settings below you must edit the ebuild."
	ewarn
	ewarn "Maximum nick length       = ${MAX_NICK_LENGTH}"
	ewarn "        topic length      = ${MAX_TOPIC_LENGTH}"
	ewarn "        number of clients = ${MAX_CLIENTS}"
	ewarn

	if [ ${ENABLE_SMALL_NETWORK} -eq 1 ]
	then
		einfo "Configuring for small networks."
		myconf="${myconf} --enable-small-net"
	else
		myconf="${myconf} --disable-small-net"
	fi
	if [ ${ENABLE_EFNET} -eq 1 ]
	then
		einfo "Configuring for Efnet."
		myconf="${myconf} --enable-efnet"
	else
		myconf="${myconf} --disable-efnet"
	fi

	epause 5

	econf \
		--exec-prefix=/usr \
		--bindir=/usr/bin \
		--sysconfdir=/etc/ircd \
		--includedir=/usr/include \
		--with-nicklen=${MAX_NICK_LENGTH} \
		--with-topiclen=${MAX_TOPIC_LENGTH} \
		--with-maxconn=${MAX_CLIENTS} \
		$(use_enable zlib) \
		$(use_enable ssl openssl) \
		$(use_enable !static shared-modules) \
		$(use_enable debug assert) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"

	# Build respond binary for using rsa keys instead of plain text oper passwords.
	use ssl && $(tc-getCC) ${CFLAGS} -o respond tools/rsa_respond/respond.c -lcrypto
}

src_install() {
	dodir /usr/lib/ircd-hybrid-7
	keepdir /var/run/ircd /var/log/ircd

	make DESTDIR="${D}" install || die "make install failed"

	insinto /usr/share/ircd-hybrid-7/messages
	doins messages/*.lang || die "doins failed"

	mv "${D}"/usr/{modules,lib/ircd-hybrid-7}
	mv "${D}"/usr/bin/{,ircd-}mkpasswd
	mv "${D}"/etc/ircd/{example,ircd}.conf

	sed -i \
		-e s:/usr/local/ircd/modules:/usr/lib/ircd-hybrid-7/modules: \
		"${D}"/etc/ircd/ircd.conf

	use ssl && dosbin "${S}"/respond

	dodoc BUGS ChangeLog Hybrid-team RELNOTES TODO
	docinto doc
	dodoc doc/*.txt doc/Tao-of-IRC.940110 doc/server-version-info
	docinto doc/technical
	dodoc doc/technical/*

	newinitd "${FILESDIR}"/init.d_ircd-7.1.0 ircd
}

pkg_postinst() {
	chown -R hybrid:hybrid "${ROOT}"/etc/ircd "${ROOT}"/var/{log,run}/ircd
	chmod 700 "${ROOT}"/etc/ircd "${ROOT}"/var/log/ircd

	if use ssl
	then
		einfo "To create an RSA keypair for crypted links execute:"
		einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	fi
}

pkg_config() {
	einfo "Generating 2048 bit RSA keypair /etc/ircd/ircd.rsa."
	einfo "The public key is stored in /etc/ircd/ircd.pub."

	openssl genrsa -rand "${ROOT}"/var/run/random-seed -out "${ROOT}"/etc/ircd/ircd.rsa 2048
	openssl rsa -in "${ROOT}"/etc/ircd/ircd.rsa -pubout -out "${ROOT}"/etc/ircd/ircd.pub

	chown hybrid:hybrid "${ROOT}"/etc/ircd/ircd.rsa "${ROOT}"/etc/ircd/ircd.pub
	chmod 600 "${ROOT}"/etc/ircd/ircd.rsa
	chmod 644 "${ROOT}"/etc/ircd/ircd.pub

	einfo "Update the RSA keypair in /etc/ircd/ircd.conf and /REHASH."
}
