# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/unrealircd/unrealircd-3.2.8.1-r2.ebuild,v 1.3 2012/02/05 17:51:26 armin76 Exp $

EAPI=3

inherit eutils autotools ssl-cert versionator multilib

MY_P=Unreal${PV}

DESCRIPTION="aimed to be an advanced (not easy) IRCd"
HOMEPAGE="http://www.unrealircd.com/"
SRC_URI="mirror://gentoo/${MY_P}-notrojan.tar.gz"
#SRC_URI="http://www.unrealircd.com/downloads/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux"
IUSE="curl +hub ipv6 +operoverride +spoof operoverride-verify +prefixaq
showlistmodes shunnotices ssl topicisnuhost +usermod zlib"

RDEPEND="ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	curl? ( net-misc/curl[ares] )
	dev-libs/tre
	>=net-dns/c-ares-1.5.3"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	>=dev-util/pkgconfig-0.25"

S="${WORKDIR}/Unreal$(get_version_component_range 1-2)"

pkg_setup() {
	enewuser unrealircd
}

src_prepare() {
	#QA check against bundled pkgs
	rm extras/*.gz || die

	sed -i \
		-e "s:ircd\.pid:${EPREFIX}/var/run/unrealircd/ircd.pid:" \
		-e "s:ircd\.log:${EPREFIX}/var/log/unrealircd/ircd.log:" \
		-e "s:debug\.log:${EPREFIX}/var/log/unrealircd/debug.log:" \
		-e "s:ircd\.tune:${EPREFIX}/var/lib/unrealircd/ircd.tune:" \
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
	local myconf=()
	use curl     && myconf+=(--enable-libcurl="${EPREFIX}"/usr)
	use ipv6     && myconf+=(--enable-inet6)
	use zlib     && myconf+=(--enable-ziplinks="${EPREFIX}"/usr)
	use hub      && myconf+=(--enable-hub)
	use ssl      && myconf+=(--enable-ssl="${EPREFIX}"/usr)
	use prefixaq && myconf+=(--enable-prefixaq)
	use spoof  && myconf+=(--enable-nospoof)
	use showlistmodes && myconf+=(--with-showlistmodes)
	use topicisnuhost && myconf+=(--with-topicisnuhost)
	use shunnotices && myconf+=(--with-shunnotices)
	use operoverride || myconf+=(--with-no-operoverride)
	use operoverride-verify && myconf+=(--with-operoverride-verify)
	use usermod || myconf+=(--with-disableusermod)

	econf \
		--with-listen=5 \
		--with-dpath="${ED}"/etc/unrealircd \
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
		"${myconf[@]}"

	# Fix upstream poor autofoo
	sed -i \
		-e "s:${D%/}::g" \
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
		-e s:src/modules:"${EPREFIX}"/usr/$(get_libdir)/unrealircd/modules: \
		-e s:ircd\\.log:"${EPREFIX}"/var/log/unrealircd/ircd.log: \
		"${ED}"/etc/unrealircd/unrealircd.conf \
		|| die

	dodoc \
		Changes Donation Unreal.nfo networks/makenet \
		ircdcron/{ircd.cron,ircdchk} \
		|| die "dodoc failed"
	dohtml doc/*.html || die

	newinitd "${FILESDIR}"/unrealircd.rc unrealircd || die
	newconfd "${FILESDIR}"/unrealircd.confd unrealircd

	fperms 700 /etc/unrealircd || die
	fowners -R unrealircd /{etc,var/{lib,log,run}}/unrealircd || die
}

pkg_postinst() {
	# Move docert call from scr_install() to install_cert in pkg_postinst for
	# bug #201682
	if use ssl ; then
		if [[ ! -f "${EROOT}"/etc/unrealircd/server.cert.key ]]; then
			install_cert /etc/unrealircd/server.cert
			chown unrealircd "${EROOT}"/etc/unrealircd/server.cert.*
			ln -snf server.cert.key "${EROOT}"/etc/unrealircd/server.key.pem
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
