# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-1.0.7.ebuild,v 1.1 2006/10/22 19:34:56 hansmi Exp $

inherit eutils toolchain-funcs multilib

IUSE="openssl gnutls"

DESCRIPTION="InspIRCd - The Modular C++ IRC Daemon"
HOMEPAGE="http://www.inspircd.org"
SRC_URI="mirror://sourceforge/${PN}/InspIRCd-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND="
	openssl? ( >=dev-libs/openssl-0.9.7d )
	gnutls? ( >=net-libs/gnutls-1.3.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/inspircd"

pkg_setup() {
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
}

# ============================================================
# inspircd_use_enable ()
#
# If something is in our USE flags, then append it to
# my_conf in the valid format as used by inspircd's configure
# script.
#
# $1 = pkg name
# $2 = inspircd variable
# $3 = inspircd value if yes
# $4 = inspircd value if no
inspircd_use_enable() {
	if use $1 ; then
		echo "$2=\"$3\"" >> .config.cache
	else
		echo "$2=\"$4\"" >> .config.cache
	fi
}

# Determines the appropriate value for the
# GCC34= configuration option.
inspircd-determine-gcc34() {
	if [[ $(gcc-major-version) -gt 3 ]] ; then
		echo "4"
	else
		if [[ $(gcc-minor-version) -lt 4 ]] ; then
			echo "3"
		else
			echo "4"
		fi
	fi
}

src_compile() {
	local myconf=""

	ewarn
	ewarn "Note that with InspIRCd 1.0.7 and later you can select"
	ewarn "which SSL engine you wish to use."
	ewarn
	ewarn "USE=ssl is no longer supported."
	ewarn
	ewarn "To select OpenSSL, put USE='openssl' in your useflags."
	ewarn "To select GnuTLS, put USE='gnutls' in your useflags."
	ewarn
	ewarn "You may compile in support for both SSL engines."
	ewarn "To do so, just do USE='openssl gnutls'."
	ewarn

	# Write a configuration file
	einfo "Building configuration parameters file."

	if use openssl; then
		einfo "Enabling OpenSSL SSL engine module."
	fi

	if use gnutls; then
		einfo "Enabling GnuTLS SSL engine module."
	fi

	cat << _EOF_ > .config.cache
CC="$(tc-getCXX)"
MAKEPROG="make $MFLAGS"
GCCVER="$(gcc-major-version)"
GCC34="$(inspircd-determine-gcc34)"
OPTIMISATI=""
FLAGS="$CXXFLAGS"
CONFIG_DIR="/etc/inspircd"
MODULE_DIR="/usr/$(get_libdir)/inspircd/modules"
BASE_DIR="/"
LIBRARY_DIR="/usr/$(get_libdir)/inspircd"
OSNAME="$(uname)"
BINARY_DIR="/usr/bin"
LDLIBS="-ldl -lstdc++"
CHANGE_COMPILER="n"
HAS_STRLCPY="false"
MAKEORDER="ircd mods"

# User defined parameters.
MAX_KICK="${INSPIRCD_KICKLEN:-255}"
MAX_IDENT="${INSPIRCD_IDENTLEN:-12}"
MAX_GECOS="${INSPIRCD_GECOSLEN:-128}"
MAX_CLIENT_T="${INSPIRCD_MAX_CLIENTS:-512}"
MAXI_MODES="${INSPIRCD_MAX_MODES:-20}"
MAX_CLIENT="${INSPIRCD_MAX_CLIENTS:-512}"
MAX_CHANNE="${INSPIRCD_MAX_CHANNELS:-20}"
NICK_LENGT="${INSPIRCD_NICKLEN:-31}"
MAX_OPERCH="${INSPIRCD_MAX_OPERCHANS:-60}"
MAX_AWAY="${INSPIRCD_AWAYLEN:-200}"
MAX_TOPIC="${INSPIRCD_TOPICLEN:-307}"
MAX_QUIT="${INSPIRCD_QUITLEN:-255}"
_EOF_

	inspircd_use_enable openssl HAS_OPENSSL y n
	inspircd_use_enable gnutls HAS_GNUTLS y n

	# build makefiles based on our configure params
	# Please note that it's not the autoconf configure script, thus
	# we don't use econf.
	./configure -update || die "configure failed"

	emake DESTDIR="${D}" || die "emake failed"
}

src_install() {
	# the inspircd buildsystem does not create these, it's configure script
	# does. so, we have to at this point to make sure they are there.
	dodir /usr/$(get_libdir)/inspircd
	dodir /usr/$(get_libdir)/inspircd/modules
	dodir /etc/inspircd
	dodir /usr/bin/ircd

	emake \
		LIBPATH="${D}/usr/$(get_libdir)/inspircd" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules" \
		CONPATH="${D}/etc/inspircd" \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/bin/inspircd.launcher" \
		install

	newinitd "${FILESDIR}"/init.d_inspircd inspircd
}

pkg_postinst() {
	chown -R inspircd:inspircd "${ROOT}"/etc/inspircd
	chmod 700 "${ROOT}"/etc/inspircd

	chown -R inspircd:inspircd "${ROOT}"/usr/$(get_libdir)/inspircd
	chmod -R 755 "${ROOT}"/usr/$(get_libdir)/inspircd

	chmod -R 755 /usr/bin/inspircd
}
