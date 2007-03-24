# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/xulrunner/xulrunner-1.8.0.4.ebuild,v 1.14 2007/03/24 14:04:45 armin76 Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils makeedit multilib autotools mozconfig-2 java-pkg-opt-2
PATCH="${P}-patches-1.1"

DESCRIPTION="Mozilla runtime package that can be used to bootstrap XUL+XPCOM applications"
HOMEPAGE="http://developer.mozilla.org/en/docs/XULRunner"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases/${PV}/source/${P}-source.tar.bz2
	mirror://gentoo/${PATCH}.tar.bz2"

LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-* amd64 ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=sys-libs/zlib-1.1.4
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.10
	>=dev-libs/nspr-4.6.1
	java? ( >=virtual/jre-1.4 )"

DEPEND="java? ( >=virtual/jdk-1.4 )
	${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/mozilla

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=xulrunner
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

src_unpack() {
	unpack ${P}-source.tar.bz2  ${PATCH}.tar.bz2

	# Apply our patches
	cd ${S} || die "cd failed"

	# exclude the xpcomglue-shared.patch from debian for now
	# until we figured out if we need also the versioning patch
	EPATCH_EXCLUDE="030_pango-cairo-1.patch.bz2"

	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"/patch

	# Fix a compilation issue using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, it detects a ppc64 system.
	# -- hansmi, 2005-11-13
	if use ppc && [[ "${PROFILE_ARCH}" == ppc64 ]]; then
		sed -i -e "s#OS_TEST=\`uname -m\`\$#OS_TEST=${ARCH}#" \
			${S}/configure
		sed -i -e "s#OS_TEST :=.*uname -m.*\$#OS_TEST:=${ARCH}#" \
			${S}/security/coreconf/arch.mk
	fi

	eautoreconf || die "failed  running eautoreconf"
}

src_compile() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	mozconfig_annotate '' --enable-extensions="default,cookie,permissions"
	mozconfig_annotate '' --enable-native-uconv
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	#mozconfig_annotate '' --enable-js-binary
	mozconfig_annotate '' --enable-embedding-tests
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --with-system-bz2
	mozconfig_annotate '' --enable-jsd
	mozconfig_annotate '' --enable-xpctools
	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	#disable java 
	if ! use java ; then
	    mozconfig_annotate '-java' --disable-javaxpcom
	fi

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	gcc-specs-ssp && append-flags -fno-stack-protector-all
	# remove -fstack-protector because now it borks firefox
	CFLAGS=${CFLAGS/-fstack-protector-all/}
	CFLAGS=${CFLAGS/-fstack-protector/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector-all/}
	CXXFLAGS=${CXXFLAGS/-fstack-protector/}

	append-flags -freorder-blocks -fno-reorder-functions

	# Export CPU_ARCH_TEST  as it is not exported by default.
	case $(tc-arch) in
	amd64) [[ ${ABI} == "x86" ]] && CPU_ARCH_TEST="x86" || CPU_ARCH_TEST="x86_64" ;;
	*) CPU_ARCH_TEST=$(tc-arch) ;;
	esac

	export CPU_ARCH_TEST

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS} -DARON_WAS_HERE" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# It would be great if we could pass these in via CPPFLAGS or CFLAGS prior
	# to econf, but the quotes cause configure to fail.
	sed -i -e \
		's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|' \
		${S}/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake -j1 || die
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}
	einstall || die "failed running make install"

	if use java ; then
	    java-pkg_dojar ${D}${MOZILLA_FIVE_HOME}/javaxpcom.jar
	    rm -f ${D}${MOZILLA_FIVE_HOME}/javaxpcom.jar
	fi

	# xulrunner registration, the gentoo way
	insinto /etc/gre.d
	newins ${FILESDIR}/${PN}.conf ${PV}.conf
	sed -i -e \
		"s|version|${PV}|
			s|instpath|${MOZILLA_FIVE_HOME}|" \
		${D}/etc/gre.d/${PV}.conf
}
