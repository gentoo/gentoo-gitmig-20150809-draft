# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libosip/libosip-0.8.8.ebuild,v 1.1 2002/08/28 00:44:39 gaarde Exp $

# AUTHOR: Paul Belt <gaarde@gentoo.org>

DESCRIPTION="This is the oSIP library (for Open SIP). It has been designed to provide the Internet Community a simple way to support the Session Initiation Protocol.  SIP is described in the RFC2543 which is available at http://www.ietf.org/rfc/rfc2543.txt."

# In french
# if use french; then \
#    HOMEPAGE="http://www.linphone.org/"
# elsif use english; then \
#    HOMEPAGE="http://www.linphone.org/?lang=us"
# fi

# In english
HOMEPAGE="http://www.linphone.org/?lang=us"

SRC_URI="http://www.linphone.org/download/${P}.tar.gz"

LICENSE="LGPL-2"

SLOT="1"

KEYWORDS="x86"

RDEPEND=""

DEPEND="${RDEPEND}"

src_compile() {
    EXTRA_FLAGS=''

   if use pic; then
      flags="${flags} --with-pic";
   else
      flags="${flags} --without-pic"
   fi

	econf ${EXTRA_FLAGS} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README TODO
}
