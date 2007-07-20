# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mozilla-thunderbird/mozilla-thunderbird-2.0.0.5.ebuild,v 1.1 2007/07/20 15:57:43 armin76 Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib mozextension autotools

PATCH="${PN}-2.0.0.4-patches-0.1"
LANGS="be bg ca cs da de el en-GB es-AR es-ES eu fi fr ga-IE hu it ja lt mk nb-NO nl nn-NO pa-IN pl pt-BR pt-PT ru sk sl sv-SE tr zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-TW"

DESCRIPTION="Thunderbird Mail Client"
HOMEPAGE="http://www.mozilla.com/en-US/thunderbird/"

KEYWORDS="~alpha ~amd64 ~ia64 -mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE="ldap crypt bindist mozdom replytolist"

MOZ_URI="http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases/${PV}"
SRC_URI="${MOZ_URI}/source/thunderbird-${PV}-source.tar.bz2
	mirror://gentoo/${PATCH}.tar.bz2"

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/thunderbird/releases/${MY_PV}/linux-i686/xpi/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://dev.gentooexperimental.org/~armin76/dist/${P}-xpi/${P}-${X}.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		SRC_URI="${SRC_URI}
			linguas_${X%%-*}? ( http://dev.gentooexperimental.org/~armin76/dist/${P}-xpi/${P}-${X}.xpi )"
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

RDEPEND=">=www-client/mozilla-launcher-1.56
	>=dev-libs/nss-3.11.5
	>=dev-libs/nspr-4.6.5-r1"

PDEPEND="crypt? ( >=x11-plugins/enigmail-0.95.1 )
		replytolist? ( x11-plugins/replytolist )"

S="${WORKDIR}/mozilla"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=mail
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

pkg_setup(){
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if ! use bindist; then
		elog "You are enabling official branding. You may not redistribute this build"
		elog "to any users on your network or the internet. Doing so puts yourself into"
		elog "a legal problem with mozilla foundation"
	fi

	use moznopango && warn_mozilla_launcher_stub
}

src_unpack() {
	unpack thunderbird-${PV}-source.tar.bz2  ${PATCH}.tar.bz2

	for X in ${A}; do
		[[ ${X} == *.xpi ]] && xpi_unpack ${X}
	done

	# Apply our patches
	cd "${S}" || die "cd failed"
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"/patch

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

	# tb-specific settings
	mozconfig_use_enable ldap
	mozconfig_use_enable ldap ldap-experimental
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-user-appdir=.thunderbird
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss

	# Bug #72667
	if use mozdom; then
		mozconfig_annotate '' --enable-extensions=default,inspector
	else
		mozconfig_annotate '' --enable-extensions=default
	fi

	if ! use bindist; then
		mozconfig_annotate '' --enable-official-branding
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

	CPPFLAGS="${CPPFLAGS}" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	elog "Removing old installs though some really ugly code.  It potentially"
	elog "eliminates any problems during the install, however suggestions to"
	elog "replace this are highly welcome.  Send comments and suggestions to"
	elog "mozilla@gentoo.org."
	rm -rf "${ROOT}"/"${MOZILLA_FIVE_HOME}"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Most of the installation happens here
	dodir "${MOZILLA_FIVE_HOME}"
	cp -RL "${S}"/dist/bin/* "${D}"/"${MOZILLA_FIVE_HOME}"/ || die "cp failed"

	for X in ${A}; do
		[[ ${X} == *.xpi ]] && xpi_install "${WORKDIR}"/${X%.xpi}
	done

	# Create directory structure to support portage-installed extensions.
	# See update_chrome() in mozilla-launcher
	keepdir ${MOZILLA_FIVE_HOME}/chrome.d
	keepdir ${MOZILLA_FIVE_HOME}/extensions.d
	cp ${D}${MOZILLA_FIVE_HOME}/chrome/installed-chrome.txt \
		${D}${MOZILLA_FIVE_HOME}/chrome.d/0_base-chrome.txt

	# Create /usr/bin/thunderbird
	install_mozilla_launcher_stub thunderbird ${MOZILLA_FIVE_HOME}

	if ! use bindist; then
		doicon "${FILESDIR}"/icon/thunderbird-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		doicon "${FILESDIR}"/icon/thunderbird-icon-unbranded.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop
	fi

	for i in ${D}"${MOZILLA_FIVE_HOME}"/greprefs/all-gentoo.js \
		${D}"${MOZILLA_FIVE_HOME}"/defaults/pref/all-gentoo.js; do
		echo 'pref("intl.locale.matchOS",                true);' >> $i
	done

	# Install files necessary for applications to build against thunderbird
	elog "Installing includes and idl files..."
	cp -LfR "${S}"/dist/include "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"
	cp -LfR "${S}"/dist/idl "${D}"/"${MOZILLA_FIVE_HOME}" || die "cp failed"

	# Dirty hack to get some applications using this header running
	dosym "${MOZILLA_FIVE_HOME}"/include/necko/nsIURI.h \
		"${MOZILLA_FIVE_HOME}"/include/nsIURI.h

	# Warn user that remerging enigmail is neccessary on USE=crypt
	use crypt && ewarn "Please remerge x11-plugins/enigmail after updating ${PN}."

}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks

	elog
	elog "The behaviour of the langpacks has changed, now ${PN}"
	elog "will be displayed in your locale"
	elog
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	update_mozilla_launcher_symlinks
}
