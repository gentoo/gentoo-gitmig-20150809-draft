# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-4.0.8.5.ebuild,v 1.4 2003/09/07 00:06:06 msterret Exp $


DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.all-day-breakfast.com/rosegarden/"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/rosegarden/rosegarden-4-0.8.5.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

# NOTE: This package may be compiled with aRt instead of alsa, and with no jack or ladspa support,
# but I don't know how to say that with the IUSE variable.
#IUSE="alsa"

DEPEND=">=gcc-2.9
        >=kdelibs-3.0
	kdemultimedia
        >=qt-3.0
        >=alsa-driver-0.9.0_rc2
        virtual/jack
        >=ladspa-sdk-1.0
        >=ladspa-cmt-1.14
        "

#RDEPEND=""

S=${WORKDIR}/rosegarden-4-0.8.5

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
                --infodir=/usr/share/info \
                --mandir=/usr/share/man \
                --with-jack \
                --with-ladspa || die "./configure failed"
	emake || die
}

src_install() {
	einstall
}
