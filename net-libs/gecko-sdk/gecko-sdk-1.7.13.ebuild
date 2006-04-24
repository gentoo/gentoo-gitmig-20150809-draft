# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gecko-sdk/gecko-sdk-1.7.13.ebuild,v 1.3 2006/04/24 09:27:33 tcort Exp $

unset ALLOWED_FLAGS  # Stupid extra-functions.sh ... bug 49179
MOZ_FREETYPE2="no"   # Need to disable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
MOZ_PANGO="yes"      # Need to enable for newer .. remove here and in mozconfig
	                 # when older is removed from tree.
inherit flag-o-matic toolchain-funcs eutils mozconfig mozilla-launcher makeedit multilib

PVER="1.0"
SVGVER="2.3.10p1"

# handle _rc versions
MY_PV=${PV/_alpha/a} 	# handle alpha
MY_PV=${MY_PV/_beta/b}	# handle beta
MY_PV=${MY_PV/_rc/rc}	# handle rc

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.mozilla.org"
SRC_URI="http://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla${MY_PV}/source/mozilla-${MY_PV}-source.tar.bz2
	mozsvg? (
		mirror://gentoo/moz_libart_lgpl-${SVGVER}.tar.bz2
		http://dev.gentoo.org/~azarah/mozilla/moz_libart_lgpl-${SVGVER}.tar.bz2
	)
	mirror://gentoo/mozilla-${PV}-patches-${PVER}.tar.bz2
	http://dev.gentoo.org/~anarchy/dist/mozilla-${PV}-patches-${PVER}.tar.bz2"

KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="MPL-1.1 NPL-1.1"
IUSE="crypt gnome java ldap mozcalendar mozdevelop moznocompose moznoirc moznomail mozsvg postgres ssl"

# xrender.pc appeared for the first time in xorg-x11-6.7.0-r2
# and is required to build with support for cairo.  #71504
RDEPEND="java? ( virtual/jre )
	mozsvg? ( !<x11-base/xorg-x11-6.7.0-r2 )
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.2.1 ) )
	>=www-client/mozilla-launcher-1.42"

DEPEND="${RDEPEND}
	~sys-devel/autoconf-2.13
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl
	postgres? ( >=dev-db/postgresql-7.2.0 )"

S=${WORKDIR}/mozilla


src_unpack() {
	unpack mozilla-${MY_PV}-source.tar.bz2 mozilla-${PV}-patches-${PVER}.tar.bz2
	cd ${S} || die

	if use mozsvg; then
		cd ${S}/other-licenses
		unpack moz_libart_lgpl-${SVGVER}.tar.bz2
	fi
	cd ${S}

	####################################
	#
	# patch collection
	#
	####################################

	# Firefox only patches
	rm -f ${WORKDIR}/patch/{093,094,402,407}*
	# Need pango-1.10.0 stable
	rm -f ${WORKDIR}/patch/03[67]*
	epatch ${WORKDIR}/patch

	# Without 03[67]* patches, we need to link to pangoxft
	epatch ${FILESDIR}/mozilla-1.7.12-gtk2xft-link-pangoxft.patch

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	# Needed by some of the patches
	WANT_AUTOCONF=2.1 autoconf || die "WANT_AUTOCONF failed"
}

src_compile() {
	declare x
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/gecko-sdk"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml

	# Other moz-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_use_enable gnome gnomevfs
	mozconfig_use_extension gnome gnomevfs
	mozconfig_use_enable mozsvg svg
	mozconfig_use_enable mozsvg svg-renderer-libart
	use mozsvg && export MOZ_INTERNAL_LIBART_LGPL=1
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}/lib
	mozconfig_annotate '' --with-user-appdir=.mozilla
	mozconfig_annotate gentoo --disable-mailnews
	mozconfig_annotate gentoo --disable-composer
	mozconfig_annotate gentoo --disable-calendar
	mozconfig_annotate gentoo --enable-extensions=-irc

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	gcc-specs-ssp && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

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
		${S}/nsprpub/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# Fixup the RPATH
	sed -i -e \
		's|#RPATH_FIXER|'"${MOZILLA_FIVE_HOME}/lib"'|' \
		${S}/config/rules.mk \
		${S}/nsprpub/config/rules.mk \
		${S}/security/coreconf/rules.mk \
		${S}/security/coreconf/rules.mk

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die

	####################################
	#
	#  Build SDK/GRE (we add all the components/chrome
	#  to make sure that our its full-featured)
	#
	####################################

	cd ${S}/embedding/config
	# Add extra libs/components/chrome we might need
	for x in libjsj.so \
	         libgtkxtbin.so \
	         components/\* \
	         components/myspell/\* \
	         chrome/\*.jar \
	         chrome/icons/default/\*; do
		echo "${x}" >> ${S}/embedding/config/basebrowser-unix
	done
	# Make sure we have all needed libs for our components
	for x in $(LD_LIBRARY_PATH="${S}/dist/bin" ldd ${S}/dist/bin/components/*.so 2>&1 | \
	               awk '$3 ~ "dist/bin" {print $1}' | sort -u) ; do
		echo "${x}" >> ${S}/embedding/config/basebrowser-unix
	done
	# Update installed-chrome.txt
	rm -f ${S}/embedding/config/installed-chrome.txt
	cp -f ${S}/dist/bin/chrome/installed-chrome.txt ${S}/embedding/config/
	# Build the embedded dist
	emake || die
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/gecko-sdk"

	dodir /usr/$(get_libdir)
	cp -RL ${S}/dist/sdk ${D}/${MOZILLA_FIVE_HOME}
	# Also install the embedded dist for galeon, epiphany, etc
	cp -RL ${S}/dist/idl/* ${D}/${MOZILLA_FIVE_HOME}/idl/
	cp -RL ${S}/dist/include/* ${D}/${MOZILLA_FIVE_HOME}/include/
	cp -RL ${S}/dist/Embed/* ${D}/${MOZILLA_FIVE_HOME}/lib/
	# Default plugin
	cp -RL ${S}/dist/bin/plugins ${D}/${MOZILLA_FIVE_HOME}/lib/

	exeinto ${MOZILLA_FIVE_HOME}/bin
	doexe ${S}/dist/bin/regchrome
	doexe ${FILESDIR}/mozilla-rebuild-databases.pl
	dosed -e 's|/lib/gecko-sdk|/'"$(get_libdir)"'/gecko-sdk|g' \
		${MOZILLA_FIVE_HOME}/mozilla-rebuild-databases.pl

	# Fix mozilla-config and install it
	sed -i -e "s|/usr/$(get_libdir)/mozilla-${MY_PV}|${MOZILLA_FIVE_HOME}/lib|g
		s|/usr/include/mozilla-${MY_PV}|${MOZILLA_FIVE_HOME}/include|g
		s|/usr/share/idl/mozilla-${MY_PV}|${MOZILLA_FIVE_HOME}/idl|g
		s|\(echo -L.*\)\($\)|\1 -Wl,-rpath,${MOZILLA_FIVE_HOME}/lib\2|" \
		${S}/build/unix/mozilla-config
	exeinto /usr/bin
	newexe ${S}/build/unix/mozilla-config gecko-sdk-config

	# Fix pkgconfig files and install them
	insinto /usr/$(get_libdir)/pkgconfig
	for x in ${S}/build/unix/*.pc; do
		sed -i -e "s|^libdir=.*|libdir=${MOZILLA_FIVE_HOME}/lib|
			s|^includedir=.*|includedir=${MOZILLA_FIVE_HOME}/include|
			s|^idldir=.*|idldir=${MOZILLA_FIVE_HOME}/idl|
			s|\(Libs:.*\)\($\)|\1 -Wl,-rpath,\${libdir}\2|
			s|mozilla|gecko-sdk|g" ${x}
		newins ${x} $(echo "${x##*/}" | sed -e 's:mozilla:gecko-sdk:')
	done

	# Install docs
	dodoc ${S}/{LEGAL,LICENSE}
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/gecko-sdk"

	${MOZILLA_FIVE_HOME}/bin/mozilla-rebuild-databases.pl
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/gecko-sdk"

	[[ -x ${MOZILLA_FIVE_HOME}/bin/mozilla-rebuild-databases.pl ]] && \
		${MOZILLA_FIVE_HOME}/bin/mozilla-rebuild-databases.pl
}
