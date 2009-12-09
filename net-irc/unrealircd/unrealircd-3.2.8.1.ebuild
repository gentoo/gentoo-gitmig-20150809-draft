# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.2.8.1.ebuild,v 1.4 2009/12/09 18:54:24 armin76 Exp $

EAPI="2"

inherit eutils autotools ssl-cert versionator multilib

MY_P=Unreal${PV}

DESCRIPTION="aimed to be an advanced (not easy) IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="http://unrealircd.icedslash.com/${MY_P}.tar.gz
	http://unreal.brueggisite.de/${MY_P}.tar.gz
	http://www.blurryfox.com/unreal/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ppc sparc x86 ~x86-fbsd"
IUSE="curl +hub ipv6 +operoverride +spoof operoverride-verify +prefixaq
showlistmodes shunnotices ssl topicisnuhost +usermod zlib"

RDEPEND="ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	curl? ( net-misc/curl )
	dev-libs/tre
	>=net-dns/c-ares-1.5.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/Unreal$(get_version_component_range 1-2)"

pkg_setup() {
	enewuser unrealircd
}

src_prepare() {
	#QA check against bundled pkgs
	rm extras/*.gz

	sed -i \
		-e "s:ircd\.pid:/var/run/unrealircd/ircd.pid:" \
		-e "s:ircd\.log:/var/log/unrealircd/ircd.log:" \
		-e "s:debug\.log:/var/log/unrealircd/debug.log:" \
		-e "s:ircd\.tune:/var/lib/unrealircd/ircd.tune:" \
		include/config.h \
		|| die "sed failed"

	# http://bugs.unrealircd.org/view.php?id=3842
	epatch "${FILESDIR}"/unrealircd-system-tre.patch || die "epatch failed"

	epatch "${FILESDIR}"/unrealircd-system-cares.patch || die "epatch failed"

	mv autoconf/configure.in ./ || die
	mv autoconf/aclocal.m4 ./acinclude.m4 || die
	#can't call eautoreconf because aclocal's source files aren't even in unearlircd's svn!
	eaclocal
	eautoconf
}

src_configure() {
	local myconf=""
	use curl     && myconf="${myconf} --enable-libcurl=/usr"
	use ipv6     && myconf="${myconf} --enable-inet6"
	use zlib     && myconf="${myconf} --enable-ziplinks"
	use hub      && myconf="${myconf} --enable-hub"
	use ssl      && myconf="${myconf} --enable-ssl"
	use prefixaq && myconf="${myconf} --enable-prefixaq"
	use spoof  && myconf="${myconf} --enable-nospoof"
	use showlistmodes && myconf="${myconf} --with-showlistmodes"
	use topicisnuhost && myconf="${myconf} --with-topicisnuhost"
	use shunnotices && myconf="${myconf} --with-shunnotices"
	use operoverride || myconf="${myconf} --with-no-operoverride"
	use operoverride-verify && myconf="${myconf} --with-operoverride-verify"
	use usermod || myconf="${myconf} --with-disableusermod"

	econf \
		--with-listen=5 \
		--with-dpath="${D}"/etc/unrealircd \
		--with-spath=/usr/bin/unrealircd \
		--with-nick-history=2000 \
		--with-sendq=3000000 \
		--with-bufferpool=18 \
		--with-hostname=$(hostname -f) \
		--with-permissions=0600 \
		--with-fd-setsize=1024 \
		--with-system-cares \
		--with-system-tre \
		--enable-dynamic-linking \
		${myconf}

	# Fix upstream poor autofoo
	sed -i \
		-e "s:${D}::g" \
		include/setup.h \
		ircdcron/ircdchk \
		|| die
}

src_compile() {
	emake MAKE=make IRCDDIR=/etc/unrealircd || die "emake failed"
}

src_install() {
	keepdir /var/{lib,log,run}/unrealircd

	newbin src/ircd unrealircd || die

	exeinto /usr/$(get_libdir)/unrealircd/modules
	doexe src/modules/*.so || die

	dodir /etc/unrealircd
	dosym /var/lib/unrealircd /etc/unrealircd/tmp || die

	insinto /etc/unrealircd
	doins {badwords.*,help,spamfilter,dccallow}.conf || die
	newins doc/example.conf unrealircd.conf || die

	insinto /etc/unrealircd/aliases
	doins aliases/*.conf || die
	insinto /etc/unrealircd/networks
	doins networks/*.network || die

	sed -i \
		-e s:src/modules:/usr/$(get_libdir)/unrealircd/modules: \
		-e s:ircd\\.log:/var/log/unrealircd/ircd.log: \
		"${D}"/etc/unrealircd/unrealircd.conf \
		|| die

	dodoc \
		Changes Donation Unreal.nfo networks/makenet \
		ircdcron/{ircd.cron,ircdchk} \
		|| die "dodoc failed"
	dohtml doc/*.html || die

	newinitd "${FILESDIR}"/unrealircd.rc unrealircd || die
	newconfd "${FILESDIR}"/unrealircd.confd unrealircd

	fperms 700 /etc/unrealircd || die
	chown -R unrealircd "${D}"/{etc,var/{lib,log,run}}/unrealircd ||die
}

pkg_postinst() {
	# Move docert call from scr_install() to install_cert in pkg_postinst for
	# bug #201682
	if use ssl ; then
		if [[ ! -f "${ROOT}"/etc/unrealircd/server.cert.key ]]; then
			install_cert /etc/unrealircd/server.cert || die
			chown unrealircd "${ROOT}"/etc/unrealircd/server.cert.* || die
			ln -snf server.cert.key "${ROOT}"/etc/unrealircd/server.key.pem || die
		fi
	fi

	elog
	elog "UnrealIRCd will not run until you've set up /etc/unrealircd/unrealircd.conf"
	elog
	elog "You can find example cron scripts here:"
	elog "   /usr/share/doc/${PF}/ircd.cron.gz"
	elog "   /usr/share/doc/${PF}/ircdchk.gz"
	elog
	elog "You can also use /etc/init.d/unrealircd to start at boot"
	elog
}
