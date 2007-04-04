# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.8.3.ebuild,v 1.5 2007/04/04 12:30:33 armin76 Exp $

inherit flag-o-matic

IUSE="batch doc fasttrack gd gnutella gtk guionly magic"

DESCRIPTION="MLDonkey is a multi-network P2P application written in Ocaml, coming with its own Gtk GUI, web and telnet interface."
HOMEPAGE="http://mldonkey.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ia64 ~ppc ~sparc x86"
RESTRICT="nomirror"

RDEPEND="dev-lang/perl
	guionly? ( >=gnome-base/librsvg-2.4.0
			>=dev-ml/lablgtk-2.6 )
	gtk? ( >=gnome-base/librsvg-2.4.0
			>=dev-ml/lablgtk-2.6 )
	gd? ( >=media-libs/gd-2.0.28 )
	magic? ( sys-apps/file )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	!batch? ( >=dev-lang/ocaml-3.08.3 )
	batch? ( net-misc/wget )"

MLUSER="p2p"

pkg_setup() {
	if use gtk; then
		echo ""
		einfo "If the compile with gui fails, and you have updated Ocaml"
		einfo "recently, you may have forgotten that you need to run"
		einfo "/usr/portage/dev-lang/ocaml/files/ocaml-rebuild.sh"
		einfo "to learn which ebuilds you need to recompile"
		einfo "each time you update Ocaml to a different version"
		einfo "see the Ocaml ebuild for details"
		echo ""
	fi

	if use gtk && !(built_with_use dev-ml/lablgtk svg); then
		eerror "dev-ml/lablgtk must be built with the 'svg' USE flag to use the gtk gui"
		die "Recompile dev-ml/lablgtk with enabled svg USE flag"
	fi

	if use gd && !(built_with_use media-libs/gd truetype); then
		eerror "media-libs/gd must be built with 'truetype' to compile"
		eerror "MLDonkey with gd support"
		die "Recompile media-libs/gd with enabled truetype USE flag"
	fi
}

src_unpack() {
	unpack ${A} && cd "${S}"

	export WANT_AUTOCONF=2.5
	cd "${S}"/config
	autoconf
	cd "${S}"
}

src_compile() {
	append-ldflags -Wl,-z,noexecstack

	# the dirs are not (yet) used, but it doesn't hurt to specify them anyway

	# batch 	Automatically download and build OCAML-3.08.3 for compiling itself
	# onlygui	Disable all nets support, build only chosen GUI

	if use gtk || use guionly; then
		myconf="--enable-gui=newgui2"
	else
		myconf="--disable-gui"
	fi

	if use guionly; then
		myconf="${myconf} --disable-multinet --disable-donkey"
	fi

	cd ${S}
	econf \
		--sysconfdir=/etc/mldonkey \
		--sharedstatedir=/var/mldonkey \
		--localstatedir=/var/mldonkey \
		--enable-checks \
		$(use_enable fasttrack) \
		$(use_enable gnutella) \
		$(use_enable gnutella gnutella2) \
		$(use_enable batch) \
		$(use_enable gd) \
		$(use_enable magic) \
		${myconf} || die "econf failed"

	export OCAMLRUNPARAM="l=256M"
	emake || die "emake failed"

	if ! use guionly; then
		emake utils || die "emake utils failed"
	fi;
}

src_install() {
	if ! use guionly; then
		dobin mlnet mld_hash get_range copysources make_torrent subconv \
			${FILESDIR}/mldonkey || die "dobin failed"

		insinto /etc/conf.d; newins "${FILESDIR}/mldonkey.confd-2.8" mldonkey
		fperms 600 /etc/conf.d/mldonkey
		exeinto /etc/init.d; newexe "${FILESDIR}/mldonkey.initd-2.8-r1" mldonkey
	fi

	if use gtk; then
		dobin mlgui mlguistarter || die "dobin failed"
		domenu ${FILESDIR}/${PN}-gui.desktop
		doicon ${FILESDIR}/${PN}.png
	fi

	if use doc ; then
		cd ${S}/distrib
		dodoc ChangeLog *.txt
		dohtml *.html

		insinto /usr/share/doc/${PF}/scripts
		doins kill_mldonkey mldonkey_command mldonkey_previewer make_buginfo

		cd ${S}/docs
		dodoc *.txt *.tex *.pdf
		dohtml *.html

		cd ${S}/docs/developers
		dodoc *.txt *.tex

		cd ${S}/docs/images
		insinto /usr/share/doc/${PF}/html/images
		doins *
	fi
}

pkg_preinst() {
	if ! use guionly; then
		enewuser ${MLUSER} -1 /bin/bash /home/p2p users
	fi
}

pkg_postinst() {
	if ! use guionly; then
		echo
		einfo "Running \`mldonkey' will start the server inside ~/.mldonkey/"
		einfo "If you want to start MLDonkey in a particular working directory,"
		einfo "use the \`mlnet' command."
		einfo "If you want to start MLDonkey as a system service, use"
		einfo "the /etc/init.d/mldonkey script. To control bandwidth, use"
		einfo "the 'slow' and 'fast' arguments. Be sure to have a look at"
		einfo "/etc/conf.d/mldonkey also."
		echo
		einfo "Attention: 2.6 has changed the inifiles structure, so downgrading"
		einfo "will be problematic."
		einfo "User settings (admin) are transferred to users.ini from "
		einfo "downloads.ini"
		einfo "Old ini files are automatically converted to the new format"
		echo
	else
		echo
		einfo "Simply run mlgui to start the chosen MLDonkey gui."
		einfo "It puts its config files into ~/.mldonkey"
	fi
}
