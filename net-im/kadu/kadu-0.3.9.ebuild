# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kadu/kadu-0.3.9.ebuild,v 1.4 2005/03/18 15:11:32 sekretarz Exp $

inherit flag-o-matic eutils

DESCRIPTION="QT version of popular in Poland Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net/"
SRC_URI="http://kadu.net/download/stable/${P/_/-}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE="debug alsa arts esd voice nas oss spell ssl tcltk xmms"

DEPEND=">=x11-libs/qt-3.0.1
	alsa? ( media-libs/alsa-lib virtual/alsa )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	nas? ( media-libs/nas )
	spell? ( app-text/aspell )
	ssl? ( dev-libs/openssl )
	tcltk? ( >=dev-lang/tcl-8.4.0 >=dev-lang/tk-8.4.0 )
	xmms? ( media-sound/xmms )"

S=${WORKDIR}/${PN}

module_config() {
	sed -i -r "s/(^module_${1}\\s*=\\s*).*/\\1${2}/" .config
}

src_compile() {
	filter-flags -fno-rtti
	local myconf

	use debug && myconf="${myconf} --enable-debug"

	# static modules (disable only, do not compile as .so)
	use ssl || module_config encryption n
	use voice || module_config voice n

	# dynamic modules
	use alsa || use oss || module_config dsp_sound n
	use arts && module_config arts_sound m
	use esd && module_config esd_sound m
	if use nas; then
		module_config nas_sound m
		epatch "${FILESDIR}/${P}-nas-gentoo.diff"
	fi
	use spell && module_config spellchecker m
	use tcltk && module_config tcl_scripting m
	use xmms && module_config xmms m

	# enable modules, for which there are no USE flags
	module_config filedesc m
	module_config pcspeaker m

	econf ${myconf} --with-qt-libs=/usr/qt/3/$(get_libdir) || die
	emake || die
}

src_install() {
	make \
		DESTDIR=${D} \
		install || die
}
