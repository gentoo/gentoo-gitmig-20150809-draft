# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.15.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

MY_P=html_object-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/htmlobject/${MY_P}.tar.gz"
HOMEPAGE="http://htmlobject.sourceforge.net"

mydoc="LICENSE TODO"
