# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/seamonkey/seamonkey-1.1.9-r1.ebuild,v 1.1 2008/05/17 11:43:56 armin76 Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozcoreconf mozconfig-2 mozilla-launcher makeedit multilib autotools

PATCH="${P}-patches-0.2"
EMVER="0.95.6"

DESCRIPTION="Mozilla Application Suite - web browser, email, HTML editor, IRC"
HOMEPAGE="http://www.seamonkey-project.org/"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/${PN}/releases/${PV}/${P}.source.tar.bz2
	mirror://gentoo/${PATCH}.tar.bz2
	crypt? ( !moznomail? ( http://www.mozilla-enigmail.org/download/source/enigmail-${EMVER}.tar.gz ) )"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="java ldap mozdevelop moznocompose moznoirc moznomail moznoroaming postgres crypt xforms"

RDEPEND="java? ( virtual/jre )
	>=www-client/mozilla-launcher-1.56
	>=dev-libs/nss-3.11.5
	>=dev-libs/nspr-4.6.5-r1
	crypt? ( !moznomail? ( >=app-crypt/gnupg-1.4 ) )"

DEPEND="${RDEPEND}
	java? ( >=dev-java/java-config-0.2.0 )
	dev-lang/perl
	postgres? ( >=dev-db/postgresql-7.2.0 )"

S="${WORKDIR}/mozilla"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=suite
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

pkg_setup() {
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Pango is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge pango."
		die "Pango needs X"
	fi

	use moznopango && warn_mozilla_launcher_stub
}

src_unpack() {
	unpack ${P}.source.tar.bz2 ${PATCH}.tar.bz2

	# Apply our patches
	cd "${S}" || die "cd failed"
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"/patch

	# Unpack the enigmail plugin
	if use crypt && ! use moznomail; then
		cd "${S}"/mailnews/extensions || die
		unpack enigmail-${EMVER}.tar.gz
		cd "${S}"/mailnews/extensions/enigmail || die "cd failed"
		makemake2
	fi

	# Fix scripts that call for /usr/local/bin/perl #51916
	ebegin "Patching smime to call perl from /usr/bin"
	sed -i -e '1s,usr/local/bin,usr/bin,' "${S}"/security/nss/cmd/smimetools/smime
	eend $? || die "sed failed"

	cd "${S}"
	eautoreconf
}

src_compile() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################
	mozconfig_init
	mozconfig_config

	mozconfig_annotate 'gentoo' --enable-canvas
	mozconfig_annotate 'gentoo' --with-system-nspr
	mozconfig_annotate 'gentoo' --with-system-nss

	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate 'galeon' --enable-oji --enable-mathml

	# Other moz-specific settings
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman

	if use moznoirc; then
		mozconfig_annotate '+moznocompose +moznoirc' --enable-extensions=-irc
	fi

	if use moznoroaming ; then
		mozconfig_annotate '+moznoroaming' --enable-extensions=-sroaming
	fi

	if use postgres ; then
		mozconfig_annotate '+postgres' --enable-extensions=sql
		export MOZ_ENABLE_PGSQL=1
		export MOZ_PGSQL_INCLUDES=/usr/include
		export MOZ_PGSQL_LIBS=/usr/$(get_libdir)
	fi

	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.mozilla

	if use moznomail; then
		mozconfig_annotate "+moznomail" --disable-mailnews
	fi

	if use moznocompose; then
		if use moznoirc && use moznomail; then
			mozconfig_annotate "+moznocompose" --disable-composer
		fi
	fi

	if use xforms; then
		mozconfig_annotate "+xforms" --enable-extensions=xforms,schema-validation
	fi

	# Finalize and report settings
	mozconfig_final

	# -fstack-protector breaks us
	if gcc-version ge 4 1; then
		gcc-specs-ssp && append-flags -fno-stack-protector
	else
		gcc-specs-ssp && append-flags -fno-stack-protector-all
	fi
		filter-flags -fstack-protector -fstack-protector-all

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
		"${S}"/config/autoconf.mk \
		"${S}"/xpfe/global/buildconfig.html

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die

	####################################
	#
	#  Build Enigmail extension
	#
	####################################

	if use crypt && ! use moznomail; then
		emake -C "${S}"/mailnews/extensions/enigmail || die "make enigmail failed"
	fi
}

src_install() {
	declare MOZILLA_FIVE_HOME=/usr/$(get_libdir)/${PN}

	# Most of the installation happens here
	dodir "${MOZILLA_FIVE_HOME}"
	cp -RL "${S}"/dist/bin/* "${D}"/"${MOZILLA_FIVE_HOME}"/ || die "cp failed"

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp "${D}"${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		"${D}"${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/seamonkey
	install_mozilla_launcher_stub seamonkey ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/${PN}.png
	domenu "${FILESDIR}"/icon/${PN}.desktop

	# Fix icons to look the same everywhere
	insinto ${MOZILLA_FIVE_HOME}/icons
	doins "${S}"/widget/src/gtk/mozicon16.xpm
	doins "${S}"/widget/src/gtk/mozicon50.xpm

	####################################
	#
	# Install files necessary for applications to build against seamonkey
	#
	####################################

	elog "Installing includes and idl files..."
	cp -LfR "${S}"/dist/include "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"
	cp -LfR "${S}"/dist/idl "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"

	# Fix mozilla-config and install it
	exeinto ${MOZILLA_FIVE_HOME}
	doexe "${S}"/build/unix/${PN}-config

	# Install pkgconfig files
	insinto /usr/"$(get_libdir)"/pkgconfig
	doins "${S}"/build/unix/*.pc

	# Install env.d snippet, which isn't necessary for running mozilla, but
	# might be necessary for programs linked against firefox
	doenvd "${FILESDIR}"/10${PN}
	dosed "s|/usr/lib|/usr/$(get_libdir)|" /etc/env.d/10${PN}

	# Install rebuild script since mozilla-bin doesn't support registration yet
	exeinto ${MOZILLA_FIVE_HOME}
	doexe "${FILESDIR}"/${PN}-rebuild-databases.pl
	dosed -e 's|/lib/|/'"$(get_libdir)"'/|g' \
		${MOZILLA_FIVE_HOME}/${PN}-rebuild-databases.pl

	# Install docs
	dodoc "${S}"/{LEGAL,LICENSE}

	# Update Google search plugin to use UTF8 charset ...
	insinto ${MOZILLA_FIVE_HOME}/searchplugins
	doins "${FILESDIR}"/google.src
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Remove entire installed instance to solve various problems,
	# for example see bug 27719
	rm -rf "${ROOT}"${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update the component registry
	MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=${PN} \
		/usr/libexec/mozilla-launcher -register

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Update the component registry
	if [[ -x ${MOZILLA_FIVE_HOME}/${PN}-bin ]]; then
		MOZILLA_LIBDIR=${ROOT}${MOZILLA_FIVE_HOME} MOZILLA_LAUNCHER=${PN} \
			/usr/libexec/mozilla-launcher -register
	fi

	update_mozilla_launcher_symlinks
}
