IUSE="doc gtk nls xv alsa"

DESCRIPTION="Linphone is a Web phone with a GNOME interface. It let you make two-party calls over IP networks such as the Internet. It uses the IETF protocols SIP (Session Initiation Protocol) and RTP (Realtime Transport Protocol) to make calls, so it should be able to communicate with other SIP-based Web phones. With several codecs available, it can be used with high speed connections as well as 28k modems."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${PV}/sources/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="dev-libs/glib
	>=net-libs/libosip-0.9.6
	dev-util/pkgconfig
	xv? ( dev-lang/nasm )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2 )
	gnome? ( gnome-base/gnome-panel
	gnome-base/libgnome 
	gnome-base/libgnomeui )
	alsa? ( >media-sound/alsa-driver-0.5 )
	doc? ( dev-util/gtk-doc )"

src_compile() {

	local myconf

	if use gnome
	then
	    use gtk2 && myconf="${myconf} --enable-platform-gnome-2"
	else
	    use gnome || myconf="${myconf}--enable-gnome_ui=no"
	fi

	if use gtk && use doc
	then
		myconf="${myconf} --enable-gtk-doc"
	else
		myconf="${myconf} --disable-gtk-doc"
	fi

	econf \
		`use_enable alsa` \
		`use_enable nls` \
		${myconf} || die
	emake || die
}

src_install () {
	dodoc ABOUT-NLS COPYING README AUTHORS BUGS INSTALL NEWS ChangeLog TODO
	einstall PIXDESTDIR=${D} || die
}
