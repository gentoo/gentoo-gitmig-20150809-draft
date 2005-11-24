# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.4.3.ebuild,v 1.5 2005/11/24 21:52:05 cryos Exp $

inherit kde flag-o-matic eutils multilib
set-kdedir 3.4

DESCRIPTION="KDE libraries needed by all kde programs"
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.4"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~mips ~ppc ppc64 sparc ~x86"
IUSE="alsa arts cups doc jpeg2k kerberos openexr spell ssl tiff zeroconf"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.
RDEPEND="$(qt_min_version 3.3.3)
	arts? ( ~kde-base/arts-${PV} )
	app-arch/bzip2
	>=media-libs/freetype-2
	media-libs/fontconfig
	>=dev-libs/libxslt-1.1.4
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-4.2
	media-libs/libart_lgpl
	net-dns/libidn
	virtual/utempter
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

pkg_setup() {
	# Workaround collision with <=kdeadmin-3.4.1 (bug #100968).
	rm -f "${ROOT}${KDEDIR}/share/mimelnk/application/x-debian-package.desktop"
}

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdelibs-3.4.1-configure.patch"

	# Missing <inttypes.h> include causes compilation to bork
	epatch "${FILESDIR}/kdelibs-3.4.3-inttypes.patch"

	# for the configure patch
	make -f admin/Makefile.common || die
}

src_compile() {
	myconf="--with-distribution=Gentoo
	        --enable-libfam $(use_enable kernel_linux dnotify)
	        --with-libart --with-libidn --with-utempter
	        $(use_with alsa) $(use_with arts) $(use_with ssl)
	        $(use_with kerberos gssapi) $(use_with tiff)
	        $(use_with jpeg2k jasper) $(use_with openexr)
	        $(use_enable cups) $(use_enable zeroconf dnssd)"

	if use spell && has_version app-text/aspell; then
		myconf="${myconf} --with-aspell"
	else
		myconf="${myconf} --without-aspell"
	fi

	myconf="${myconf} --disable-fast-malloc"

	# fix bug 58179, bug 85593
	# kdelibs-3.4.0 needed -fno-gcse; 3.4.1 needs -mminimal-toc; this needs a
	# closer look... - corsair
	use ppc64 && append-flags "-mminimal-toc"

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

		cat <<EOF > ${D}/etc/env.d/46kdepaths-${SLOT} # number goes down with version upgrade
PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs:1}
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown"
EOF
	fi

}
