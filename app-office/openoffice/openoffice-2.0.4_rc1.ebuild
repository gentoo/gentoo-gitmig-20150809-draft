# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice/openoffice-2.0.4_rc1.ebuild,v 1.3 2006/08/24 18:58:20 suka Exp $

inherit check-reqs debug eutils fdo-mime flag-o-matic java-pkg-opt-2 kde-functions mono multilib toolchain-funcs

IUSE="binfilter branding cairo eds firefox gnome gstreamer gtk java kde ldap mono odk pam xml"

MY_PV="${PV}"
PATCHLEVEL="OOD680"
SRC="ood680-m1"
S="${WORKDIR}/ooo"
S_OLD="${WORKDIR}/ooo-build-${SRC}"
CONFFILE="${S}/distro-configs/Gentoo.conf.in"
DESCRIPTION="OpenOffice.org, a full office productivity suite."

SRC_URI="http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-core.tar.bz2
	http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-system.tar.bz2
	http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-lang.tar.bz2
	binfilter? ( http://go-oo.org/packages/${PATCHLEVEL}/${SRC}-binfilter.tar.bz2 )
	http://go-oo.org/packages/${PATCHLEVEL}/ooo-build-${SRC}.tar.gz
	http://go-oo.org/packages/libwpd/libwpd-0.8.3.tar.gz
	mono? ( http://go-oo.org/packages/SRC680/cli_types.dll
		http://go-oo.org/packages/SRC680/cli_types_bridgetest.dll )
	http://tools.openoffice.org/unowinreg_prebuild/680/unowinreg.dll
	http://go-oo.org/packages/SRC680/extras-2.tar.bz2
	http://go-oo.org/packages/SRC680/hunspell_UNO_1.1.tar.gz
	http://go-oo.org/packages/xt/xt-20051206-src-only.zip
	http://go-oo.org/packages/SRC680/lp_solve_5.5.tar.gz"

LANGS="af ar be_BY bg bn bs ca cs cy da de el en en_GB en_US en_ZA es et fa fi fr gu_IN he hi_IN hr hu it ja km ko lt mk nb nl nn nr ns pa_IN pl pt pt_BR ru rw sh_YU sk sl sr_CS st sv sw_TZ th tn tr ts vi xh zh_CN zh_TW zu"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

HOMEPAGE="http://go-oo.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="!app-office/openoffice-bin
	|| ( (
			x11-libs/libXaw
			x11-libs/libXinerama
		)
		virtual/x11 )
	virtual/libc
	>=dev-lang/perl-5.0
	gnome? ( >=x11-libs/gtk+-2.4
		>=gnome-base/gnome-vfs-2.6
		>=gnome-base/gconf-2.0 )
	gtk? ( >=x11-libs/gtk+-2.4 )
	cairo? ( >=x11-libs/cairo-1.0.2
		>=x11-libs/gtk+-2.8 )
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	gstreamer? ( >=media-libs/gstreamer-0.10
			>=media-libs/gst-plugins-base-0.10 )
	kde? ( >=kde-base/kdelibs-3.2 )
	firefox? ( >=www-client/mozilla-firefox-1.5-r9
		>=dev-libs/nspr-4.6.2
		>=dev-libs/nss-3.11-r1 )
	>=x11-libs/startup-notification-0.5
	>=media-libs/freetype-2.1.10-r2
	>=media-libs/fontconfig-2.2.0
	media-libs/libpng
	sys-devel/flex
	sys-devel/bison
	app-arch/zip
	app-arch/unzip
	>=app-text/hunspell-1.1.4-r1
	dev-libs/expat
	java? ( >=virtual/jre-1.4 )
	>=sys-devel/gcc-3.2.1
	amd64? ( >=dev-libs/boost-1.33.1 )
	linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
	linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
	linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-libs/libXrender
			x11-proto/printproto
			x11-proto/xextproto
			x11-proto/xproto
			x11-proto/xineramaproto
		)
		virtual/x11 )
	net-print/cups
	>=sys-apps/findutils-4.1.20-r1
	dev-perl/Archive-Zip
	dev-perl/Compress-Zlib
	dev-util/pkgconfig
	dev-util/intltool
	>=net-misc/curl-7.9.8
	sys-libs/zlib
	sys-apps/coreutils
	pam? ( sys-libs/pam )
	!dev-util/dmake
	>=dev-lang/python-2.3.4
	app-admin/eselect-oodict
	java? ( >=virtual/jdk-1.4
		dev-java/ant-core
		>=dev-java/java-config-2.0.19-r1 )
	!java? ( dev-libs/libxslt
		>=dev-libs/libxml2-2.0 )
	ldap? ( net-nds/openldap )
	mono? ( >=dev-lang/mono-1.1.6 )
	xml? ( >=dev-libs/libxml2-2.0 )"

PROVIDE="virtual/ooo"

pkg_setup() {

	ewarn
	ewarn " It is important to note that OpenOffice.org is a very fragile  "
	ewarn " build when it comes to CFLAGS.  A number of flags have already "
	ewarn " been filtered out.  If you experience difficulty merging this  "
	ewarn " package and use agressive CFLAGS, lower the CFLAGS and try to  "
	ewarn " merge again. Also note that building OOo takes a lot of time and "
	ewarn " hardware ressources: 4-6 GB free diskspace and 256 MB RAM are "
	ewarn " the minimum requirements. If you have less, use openoffice-bin "
	ewarn " instead. "
	ewarn

	# Check if we have enough RAM and free diskspace to build this beast
	CHECKREQS_MEMORY="256"
	use debug && CHECKREQS_DISK_BUILD="8192" || CHECKREQS_DISK_BUILD="5120"
	check_reqs

	strip-linguas ${LANGS}

	if [ -z "${LINGUAS}" ]; then
		export LINGUAS_OOO="en-US"
		ewarn
		ewarn " To get a localized build, set the according LINGUAS variable(s). "
		ewarn
	else
		export LINGUAS_OOO=`echo ${LINGUAS} | \
			sed -e 's/\ben\b/en_US/g' -e 's/_/-/g'`
	fi

	if use !java; then
		ewarn " You are building with java-support disabled, this results in some "
		ewarn " of the OpenOffice.org functionality (i.e. help) being disabled. "
		ewarn " If something you need does not work for you, rebuild with "
		ewarn " java in your USE-flags. Also the xml use-flag is disabled with "
		ewarn " -java to prevent build breakage. "
		ewarn
	elif use sparc; then
		ewarn " Java support on sparc is very flaky, we don't recommend "
		ewarn " building openoffice this way."
		ebeep 5
		epause 10
	fi

	java-pkg-opt-2_pkg_setup

}

src_unpack() {

	unpack ooo-build-${SRC}.tar.gz

	# Hackish workaround for overlong path problem, see bug #130837
	mv ${S_OLD} ${S} || die

	#Some fixes for our patchset
	cd ${S}
	epatch ${FILESDIR}/${PV}/gentoo-${PV}.diff

	# Copy over some missing stuff
	cp -f ${DISTDIR}/unowinreg.dll ${S}/src

	#Use flag checks
	use java && echo "--with-jdk-home=${JAVA_HOME} --with-ant-home=${ANT_HOME}" >> ${CONFFILE} || echo "--without-java" >> ${CONFFILE}
	use branding && echo "--with-intro-bitmaps=\\\"${S}/src/openintro_gentoo.bmp\\\"" >> ${CONFFILE}
	use amd64 && echo "--with-system-boost" >> ${CONFFILE}

	echo "`use_enable binfilter`" >> ${CONFFILE}
	echo "`use_with xml system-libxml`" >> ${CONFFILE}

	echo "`use_enable firefox mozilla`" >> ${CONFFILE}
	echo "`use_with firefox system-mozilla`" >> ${CONFFILE}
	echo "`use_with firefox`" >> ${CONFFILE}

	echo "`use_enable ldap`" >> ${CONFFILE}
	echo "`use_with ldap openldap`" >> ${CONFFILE}
	echo "`use_enable eds evolution2`" >> ${CONFFILE}
	echo "`use_enable gnome gnome-vfs`" >> ${CONFFILE}
	echo "`use_enable gnome lockdown`" >> ${CONFFILE}
	echo "`use_enable gnome atkbridge`" >> ${CONFFILE}
	echo "`use_enable gstreamer`" >> ${CONFFILE}

	echo "`use_enable odk`" >> ${CONFFILE}
	echo "`use_enable debug crashdump`" >> ${CONFFILE}

}

src_compile() {

	unset LIBC
	addpredict "/bin"
	addpredict "/root/.gconfd"
	addpredict "/root/.gnome"

	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	export JOBS="1"
	if [ "${WANT_DISTCC}" == "true" ]; then
		export JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	fi

	# Compile problems with these ...
	filter-flags "-funroll-loops"
	filter-flags "-fprefetch-loop-arrays"
	filter-flags "-fno-default-inline"
	filter-flags "-fstack-protector"
	filter-flags "-ftracer"
	filter-flags "-ffast-math"
	filter-flags "-fforce-addr"
	replace-flags "-O3" "-O2"
	replace-flags "-Os" "-O2"
	replace-flags "-O1" "-O2"
	replace-flags "-O0" "-O2"

	use ppc && append-flags "-D_STLP_STRICT_ANSI"

	# Now for our optimization flags ...
	export ARCH_FLAGS="${CXXFLAGS}"

	# Make sure gnome-users get gtk-support
	export GTKFLAG="`use_enable gtk`" && use gnome && GTKFLAG="--enable-gtk"

	cd ${S}
	autoconf || die
	./configure ${MYCONF} \
		--with-distro="Gentoo" \
		--with-arch="${ARCH}" \
		--with-srcdir="${DISTDIR}" \
		--with-lang="${LINGUAS_OOO}" \
		--with-num-cpus="${JOBS}" \
		--with-binsuffix="2" \
		--with-installed-ooo-dirname="openoffice" \
		--with-tag=${SRC} \
		"${GTKFLAG}" \
		`use_enable kde` \
		`use_enable cairo` \
		`use_with cairo system-cairo` \
		`use_enable gnome quickstart` \
		`use_enable mono` \
		`use_enable pam` \
		`use_enable !debug strip` \
		--disable-access \
		--disable-post-install-scripts \
		--enable-hunspell \
		--with-system-hunspell \
		--mandir=/usr/share/man \
		--libdir=/usr/$(get_libdir) \
		|| die "Configuration failed!"

	einfo "Building OpenOffice.org..."
	use kde && set-kdedir 3
	make || die "Build failed"

}

src_install() {

	einfo "Preparing Installation"
	make DESTDIR=${D} install || die "Installation failed!"

	# Install corrected Symbol Font
	insinto /usr/share/fonts/TTF/
	doins fonts/*.ttf

	# Fix the permissions for security reasons
	chown -R root:root ${D} || die

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	eselect oodict update --libdir $(get_libdir)

	[ -x /sbin/chpax ] && [ -e /usr/$(get_libdir)/openoffice/program/soffice.bin ] && chpax -zm /usr/$(get_libdir)/openoffice/program/soffice.bin

	einfo " To start OpenOffice.org, run:"
	einfo
	einfo " $ ooffice2"
	einfo
	einfo " Also, for individual components, you can use any of:"
	einfo
	einfo " oobase2, oocalc2, oodraw2, oofromtemplate2, ooimpress2, oomath2,"
	einfo " ooweb2 or oowriter2"
	einfo
	einfo " Spell checking is now provided through our own myspell-ebuilds, "
	einfo " if you want to use it, please install the correct myspell package "
	einfo " according to your language needs. "

}
