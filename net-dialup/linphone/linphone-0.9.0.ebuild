# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/linphone/linphone-0.9.0.ebuild,v 1.1 2002/08/28 02:28:43 gaarde Exp $

# AUTHOR: Paul Belt <gaarde@gentoo.org>

DESCRIPTION="Linphone is a Web phone with a GNOME interface. It let you make two-party calls over IP networks such as the Internet. It uses the IETF protocols SIP (Session Initiation Protocol) and RTP (Realtime Transport Protocol) to make calls, so it should be able to communicate with other SIP-based Web phones. With several codecs available, it can be used with high speed connections as well as 28k modems."

# In french
# if use french; then \
#    HOMEPAGE="http://www.linphone.org/" \
# elsif use english; then \
#    HOMEPAGE="http://www.linphone.org/?lang=us"
# fi

# In english
HOMEPAGE="http://www.linphone.org/?lang=us"

SRC_URI="http://www.linphone.org/download/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="1"

KEYWORDS="x86"

RDEPEND="=net-libs/libosip-0.8.8
	   =gnome-base/gnome-panel-1.4.1
       alsa? ( >media-sound/alsa-driver-0.5 )
	   xv? ( dev-lang/nasm )
	   dev-libs/glib"

DEPEND="${RDEPEND}"

src_compile() {

   if use pic; \
      then EXTRA_FLAGS="${EXTRA_FLAGS} --with-pic"; \
      else EXTRA_FLAGS="${EXTRA_FLAGS} --without-pic"; fi

   if use alsa; \
      then EXTRA_FLAGS="${EXTRA_FLAGS} --enable-alsa"; \
      else EXTRA_FLAGS="${EXTRA_FLAGS} --disable-alsa"; fi

# Not functional at the moment
#   if use xv; \
#      then EXTRA_FLAGS="${EXTRA_FLAGS} --enable-video"; \
#      else EXTRA_FLAGS="${EXTRA_FLAGS} --disable-video"; fi

   if use nls; \
      then EXTRA_FLAGS="${EXTRA_FLAGS} --enable-nls"; \
      else EXTRA_FLAGS="${EXTRA_FLAGS} --disable-nls"; fi

   if use gtk && use doc; \
      then EXTRA_FLAGS="${EXTRA_FLAGS} --enable-gtk-doc"; \
      else EXTRA_FLAGS="${EXTRA_FLAGS} --disable-gtk-doc"; fi

	econf || die
    emake || die
}

src_install () {
    dodoc ABOUT-NLS COPYING README AUTHORS BUGS INSTALL NEWS ChangeLog TODO
	einstall PIXDESTDIR=${D} || die
}
