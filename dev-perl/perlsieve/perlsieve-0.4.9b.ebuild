# Copyright 1999-2003 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perlsieve/perlsieve-0.4.9b.ebuild,v 1.1 2003/07/20 14:01:30 mcummings Exp $
 
inherit perl-module 
  
S=${WORKDIR}/perlsieve-0.4.9 
DESCRIPTION="Access Sieve services" 
SRC_URI="http://lists.opensoftwareservices.com/websieve/${P}.tar.gz" 
HOMEPAGE="http://sourceforge.net/projects/websieve/" 
   
SLOT="0" 
LICENSE="Artistic | GPL-2" 
KEYWORDS="x86 ~amd64 ~alpha ~arm ~hppa ~mips ~ppc ~sparc" 
    
