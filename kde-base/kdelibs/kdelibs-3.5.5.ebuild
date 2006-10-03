# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.5.5.ebuild,v 1.2 2006/10/03 23:09:07 carlo Exp $

inherit kde flag-o-matic eutils multilib
set-kdedir 3.5

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2
	mirror://gentoo/kdelibs-3.5-patchset-05.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="acl alsa arts cups doc jpeg2k kerberos legacyssl noutempter openexr spell ssl tiff
zeroconf kernel_linux fam lua"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.

# Added aspell-en as dependency to work around bug 131512.
RDEPEND="$(qt_min_version 3.3.3)
	arts? ( ~kde-base/arts-${PV} )
	app-arch/bzip2
	>=media-libs/freetype-2
	media-libs/fontconfig
	>=dev-libs/libxslt-1.1.15
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-4.2
	media-libs/libart_lgpl
	net-dns/libidn
	acl? ( kernel_linux? ( sys-apps/acl ) )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	alsa? ( media-libs/alsa-lib )
	cups? ( >=net-print/cups-1.1.19 )
	tiff? ( media-libs/tiff )
	kerberos? ( virtual/krb5 )
	jpeg2k? ( media-libs/jasper )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	zeroconf? ( net-misc/mDNSResponder )
	fam? ( virtual/fam )
	virtual/ghostscript
	!noutempter? ( sys-libs/libutempter )
	!kde-base/kde-env
	lua? ( dev-lang/lua )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/gettext"

RDEPEND="${RDEPEND}
	|| ( ( x11-apps/rgb x11-apps/iceauth ) <virtual/x11-7 )
	spell? ( || (  ( app-text/aspell app-dicts/aspell-en )
			  app-text/ispell ) )"

# Testing code is rather broken and merely for developer purposes, so disable it.
RESTRICT="test"

pkg_setup() {
	if use legacyssl ; then
		echo ""
		ewarn "You have the legacyssl use flag enabled, which fixes issues with some broken"
		ewarn "sites, but breaks others instead. It is strongly discouraged to use it."
		ewarn "For more information, see bug #128922."
		echo ""
	fi
	if use noutempter ; then
		echo ""
		ewarn "Not using utempter, KDE applications won't create login records. Don't remove"
		ewarn "this functionality, unless you know exactly what you're doing."
		echo ""
	fi
}

src_unpack() {
	kde_src_unpack
	if use legacyssl ; then
		# This patch won't be included upstream, see bug #128922
		epatch "${WORKDIR}/patches/kdelibs_3.5.4-kssl-3des.patch" || die "Patch did not apply."
	fi

	# TODO - kspell2 Xspell plugins are automagically detected.
	#		 As nothing uses kspell2, don't install them.
	sed -i -e "s:plugins::" "${S}/kspell2/Makefile.am" || die "sed failed"
}

src_compile() {
	rm -f "${S}/configure"

	myconf="--with-distribution=Gentoo --disable-fast-malloc
			$(use_enable fam libfam) $(use_enable kernel_linux dnotify)
			--with-libart --with-libidn
			$(use_with acl) $(use_with ssl)
			$(use_with alsa) $(use_with arts)
			$(use_with kerberos gssapi) $(use_with tiff)
			$(use_with jpeg2k jasper) $(use_with openexr)
			$(use_enable cups) $(use_enable zeroconf dnssd)
			$(use_with !noutempter utempter) $(use_with lua)
			--without-hspell --without-aspell"

	if has_version x11-apps/rgb; then
		myconf="${myconf} --with-rgbfile=/usr/share/X11/rgb.txt"
	fi

	# fix bug 58179, bug 85593
	# kdelibs-3.4.0 needed -fno-gcse; 3.4.1 needs -mminimal-toc; this needs a
	# closer look... - corsair
	use ppc64 && append-flags "-mminimal-toc"

	# work around bug #120858, gcc 3.4.x -Os miscompilation
	use x86 && replace-flags "-Os" "-O2" # see bug #120858

	export BINDNOW_FLAGS="$(bindnow-flags)"

	kde_src_compile

	if use doc; then
		make apidox || die
	fi
}

src_install() {
	kde_src_install

	if use doc; then
		make DESTDIR="${D}" install-apidox || die
	fi

	# Needed to create lib -> lib64 symlink for amd64 2005.0 profile
	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${KDEDIR}/lib
	fi

	dodir /etc/env.d

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${PREFIX}/${libdir}"
	done

	cat <<EOF > "${D}"/etc/env.d/45kdepaths-${SLOT} # number goes down with version upgrade
PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs:1}
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
KDEDIRS="${PREFIX}:/usr:/usr/local"
#KDE_IS_PRELINKED=1
EOF
}

pkg_postinst() {
	if use zeroconf; then
		echo
		einfo "To make zeroconf support available in KDE"
		einfo "make sure that the 'mdnsd' daemon is running."
		einfo "Make sure also that multicast dns lookups are"
		einfo "enabled by editing the 'hosts:' line in"
		einfo "/etc/nsswitch.conf to include 'mdns', e.g.:"
		einfo "hosts: files mdns dns"
		echo
	fi
}
