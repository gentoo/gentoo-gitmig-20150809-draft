# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-taskmanager/xfce4-taskmanager-0.3.1.ebuild,v 1.1 2005/08/14 20:56:23 bcowan Exp $

DESCRIPTION="Xfce4 task manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

GOODIES=1

inherit xfce4

#src_compile() {
#	#set execute on autogen since it's not in the package
#	chmod +755 autogen.sh
#	./autogen.sh \
#	    --prefix=/usr \
#	    --host=${CHOST} \
#	    --mandir=/usr/share/man \
#	    --infodir=/usr/share/info \
#	    --datadir=/usr/share \
#	    --sysconfdir=/etc \
#	    --localstatedir=/var/lib 2&>1
	#have to run configure due to weird autogen
#	econf
#	emake
#}