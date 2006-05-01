# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.5.2-r4.ebuild,v 1.2 2006/05/01 15:21:33 carlo Exp $
inherit kde flag-o-matic eutils multilib
set-kdedir 3.5

DESCRIPTION="KDE libraries needed by all kde programs"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"
#SRC_URI="mirror://kde/stable/3.5/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="acl alsa arts cups doc jpeg2k kerberos legacyssl openexr spell ssl tiff zeroconf"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.
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
	virtual/utempter
	acl? ( kernel_linux? ( sys-apps/acl ) )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	alsa? ( media-libs/alsa-lib )
	cups? ( >=net-print/cups-1.1.19 )
	tiff? ( media-libs/tiff )
	kerberos? ( virtual/krb5 )
	jpeg2k? ( media-libs/jasper )
	openexr? ( >=media-libs/openexr-1.2 )
	spell? ( || ( app-text/aspell
	              app-text/ispell ) )
	zeroconf? ( net-misc/mDNSResponder )
	virtual/fam
	virtual/ghostscript"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/gettext
	dev-util/pkgconfig"

RDEPEND="${RDEPEND}
	|| ( x11-apps/rgb virtual/x11 )"

PATCHES="${FILESDIR}/${PN}-3.5.0-bindnow.patch
	${FILESDIR}/${PN}-3.5.0-kicker-crash.patch
	${FILESDIR}/${P}-xorg7-rgbtxt.patch
	${FILESDIR}/kdelibs-3.5.2-kio-fixes.diff
	${FILESDIR}/kdelibs-3.5.2-kate-fixes-2.diff
	${FILESDIR}/kdelibs-3.5.2-misc-fixes-2.diff"

pkg_setup() {
	if use legacyssl ; then
		echo ""
		eerror "Warning:"
		ewarn "You have the legacyssl use flag enabled, which fixes issues with some broken"
		ewarn "sites, but breaks others instead. It is strongly discouraged to use it."
		ewarn "For more information, see bug #128922."
		echo ""
	fi
}

src_unpack() {
	kde_src_unpack
	if use legacyssl ; then
		epatch ${FILESDIR}/kdelibs-3.5.2-kssl-3des.patch || die "Patch did not apply."
	fi
}

src_compile() {
	rm -f ${S}/configure

	# hspell is disabled because it requires version 0.9 of hspell that
	# is not in portage yet; leaving it to autodetection tries to use it
	# and then fails because of missing required functions

	myconf="--with-distribution=Gentoo
	        --enable-libfam $(use_enable kernel_linux dnotify)
	        --with-libart --with-libidn --with-utempter
	        $(use_with acl) $(use_with ssl)
	        $(use_with alsa) $(use_with arts)
	        $(use_with kerberos gssapi) $(use_with tiff)
	        $(use_with jpeg2k jasper) $(use_with openexr)
	        $(use_enable cups) $(use_enable zeroconf dnssd)
	        --without-hspell"

	if use spell && has_version app-text/aspell; then
		myconf="${myconf} --with-aspell"
	else
		myconf="${myconf} --without-aspell"
	fi

	if has_version x11-apps/rgb; then
		myconf="${myconf} --with-rgbfile=/usr/share/X11/rgb.txt"
	fi

	myconf="${myconf} --disable-fast-malloc"

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

	if ! use arts ; then
		dodir /etc/env.d

		# List all the multilib libdirs
		local libdirs
		for libdir in $(get_all_libdirs); do
			libdirs="${libdirs}:${PREFIX}/${libdir}"
		done

		cat <<EOF > ${D}/etc/env.d/45kdepaths-${SLOT} # number goes down with version upgrade
PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs:1}
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown"
EOF
	fi

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
