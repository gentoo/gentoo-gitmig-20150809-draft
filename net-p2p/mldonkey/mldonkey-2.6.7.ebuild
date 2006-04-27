# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mldonkey/mldonkey-2.6.7.ebuild,v 1.3 2006/04/27 19:24:27 mattam Exp $

inherit flag-o-matic eutils

IUSE="gtk guionly batch threads gd doc mozilla"

MOZVER="1.7"

DESCRIPTION="mldonkey is a new client to access the eDonkey network. It is written in Objective-Caml, and comes with its own GTK GUI, an HTTP interface and a telnet interface."
HOMEPAGE="http://www.nongnu.org/mldonkey/"
SRC_URI="http://savannah.nongnu.org/download/mldonkey/${P}.tar.bz2
	mozilla? ( http://www.informatik.uni-oldenburg.de/~dyna/${PN}/${MOZVER}/mldonkey_protocol_handler-${MOZVER}.xpi )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"

RDEPEND="dev-lang/perl
	gtk? ( >=gnome-base/librsvg-2.4.0
			>=dev-ml/lablgtk-2.4 )
	gd? ( >=media-libs/gd-2.0.28 )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	!batch? ( >=dev-lang/ocaml-3.08.3 )
	batch? ( net-misc/wget )"

MLUSER="p2p"

pkg_setup() {
	if use gtk; then
		echo ""
		einfo "If the compile with gui fails, and you have updated ocaml"
		einfo "recently, you may have forgotten that you need to run"
		einfo "/usr/portage/dev-lang/ocaml/files/ocaml-rebuild.sh"
		einfo "to learn which ebuilds you need to recompile"
		einfo "each time you update ocaml to a different version"
		einfo "see the ocaml ebuild for details"
		echo ""
	fi

	if use guionly && ! use gtk ; then
		echo
		eerror "You have guionly enabled, but gtk flag is disabled"
		die
	fi

	if use gtk && !(built_with_use dev-ml/lablgtk svg); then
		eerror "dev-ml/lablgtk must be built with the 'svg' USE flag to use the gtk gui"
		die "Recompile dev-ml/lablgtk with enabled svg USE flag"
	fi

	if use gd && !(built_with_use media-libs/gd truetype); then
		eerror "media-libs/gd must be built with the 'truetype' to compile"
		eerror "mldonkey with gd support"
		die "Recompile media-libs/gd with enabled truetype USE flag"
	fi

	filter-flags -fomit-frame-pointer

}

src_compile() {
	export WANT_AUTOCONF=2.5
	cd ${S}/config
	autoconf

	# the dirs are not (yet) used, but it doesn't hurt to specify them anyway

	# batch 	Automatically download and build OCAML-3.08.3 for compiling itself
	# threads 	Enables multiple threads (TURN IT ON YES WILL YA?)
	# onlygui	Disable all nets support, build only chosen GUI

	if use gtk; then
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
		`use_enable threads pthread` \
		`use_enable batch batch` \
		`use_enable gd` \
		${myconf} || die "Configure Failed!"

	export OCAMLRUNPARAM="l=256M"
	emake || die "Make Failed"

	if ! use guionly; then
		emake utils || die "make utils failed"
	fi;
}

src_install() {
	if ! use guionly; then
		dobin mlnet mld_hash get_range copysources make_torrent subconv
		dobin ${FILESDIR}/mldonkey

		insinto /etc/conf.d; newins ${FILESDIR}/mldonkey.confd mldonkey
		exeinto /etc/init.d; newexe ${FILESDIR}/mldonkey.initd mldonkey
	fi

	if use gtk; then
		dobin mlgui mlguistarter mlchat mlim mlprogress
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

	if use mozilla; then
		insinto /usr/share/${PN}
		doins ${DISTDIR}/mldonkey_protocol_handler-${MOZVER}.xpi
	fi;
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
		einfo "If you want to start mldonkey in a particular working directory,"
		einfo "use the \`mlnet' command."
		einfo "If you want to start mldonkey as a system service, use"
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
		einfo "Simply run mlgui to start the chosen modonkey gui."
		einfo "It puts its config files into ~/.mldonkey"
	fi

	if use mozilla; then
		echo
		einfo "xpi handler was placed in /usr/share/${PN} directory."
		einfo "Open it in your favorite web browser (mozilla / firefox)"
		einfo "to install extension"
		echo
	fi;
}

