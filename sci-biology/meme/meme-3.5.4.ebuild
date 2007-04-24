# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/meme/meme-3.5.4.ebuild,v 1.1 2007/04/24 20:44:01 ribosome Exp $

inherit eutils toolchain-funcs

DESCRIPTION="The MEME/MAST system - Motif discovery and search"
HOMEPAGE="http://meme.sdsc.edu/meme"
SRC_URI="http://meme.nbcr.net/downloads/${PN}_${PV}.tar.gz"
LICENSE="meme"

SLOT="0"
KEYWORDS="~x86 ~amd64"
# Other possible USE flags include "debug", "client", "server", "web",
# "queue". Other variables must be set at compile time, but only when
# the Web server is built. Right now, Web server and client are disabled.
IUSE="mpi"

# Works only with LAM-MPI.
DEPEND=">=dev-lang/perl-5.6.1
	mpi? ( sys-cluster/lam-mpi )"

S="${WORKDIR}/${PN}_${PV}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile.am.patch"
	einfo "Regenerating autotools files..."
	autoconf || die "autoconf failed"
	automake || die "automake failed"
}

src_compile() {
	local EXTRA_CONF
	# Build system is too bugy to make the programs use standard locations.
	# Put everything in "/opt" instead.
	EXTRA_CONF="${EXTRA_CONF} --prefix=/opt/${PN}"
	EXTRA_CONF="${EXTRA_CONF} --with-logs=/var/log/${PN}"
	# Connect hyperlinks to official Web site.
	EXTRA_CONF="${EXTRA_CONF} --with-url=http://meme.nbcr.net/meme"
	# Disable Web server, client and Web site.
	EXTRA_CONF="${EXTRA_CONF} --disable-server --disable-client --disable-web"
	# Parallel implementation
	if ! use mpi; then
		EXTRA_CONF="${EXTRA_CONF} --enable-serial"
	fi

	./configure ${EXTRA_CONF} || die "Configure failed."
	CC="$(tc-getCC)" ac_cc_opt="${CFLAGS}"  make -e || die "Make failed."

	if use mpi; then
		cd src/parallel
		make || die "Parallel make failed."
	fi
}

src_install() {
	make install DESTDIR="${D}" || die "Failed to install program files."
	exeinto "/opt/${PN}/bin"
	doexe "${S}/src/parallel/${PN}_p" || \
			die "Failed to install parallel MEME implementation."
	keepdir "/var/log/${PN}"
	fperms 777 "/var/log/${PN}"
}

pkg_postinst() {
	echo
	einfo 'Prior to using MEME/MAST, you should source "/opt/meme/etc/meme.sh"'
	einfo '(or "/opt/meme/etc/meme.csh" if you use a csh-style shell). To do'
	einfo 'this automatically with bash, add the following statement to your'
	einfo '"~/.bashrc" file (without the quotes): "source /opt/meme/etc/meme.sh".'
	echo
	einfo 'Log files are produced in the "/var/log/meme" directory.'
	echo
}

src_test() {
	make test || die "Regression tests failed."
}
