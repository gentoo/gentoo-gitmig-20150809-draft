# Copyright 1999-2000 Gentoo Technologies, Inc.
# /home/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-0.5.10-r6.ebuild,v 1.1 2001/10/02 20:34:44 woodchip Exp


######################## Begin version munge #########################
#This alsa version appends a alphabetic character to the beta version.
#Portage doesn't seem to play well with this type of tarball versioning
#Rather than ignore this in the ebuild version, I have encoded the
#alphabetic beta suffix as an extra number suffix on the main version,
#i.e., alsa-utils-0.9.0beta10a --> alsa-utils-0.9.0.1_beta10
#If subsequent alsa-0.9.0beta's are released, this ebuild should be
#version independent, i.e alsa-utils-0.9.0beta10b --> alsa-utils-0.9.0.2_beta10
#just requires a copy of this ebuild to the new name. If alsa releases
#version 1.0, this silliness can end.
#This is probably overkill, but it was fun :)

#Transform P to match tarball version
#Grab the last revision number, 
#"bs" is short for "beta suffix", not what you're thinking :)
bs=${PV%_beta*} #wack off _beta*
t=${bs##*.} #wack off first three numbers, save this for later

#Transform to ASCII octal number of tarball beta revision suffix
let "a=141" #The octal number for ASCII lowercase "a"
let "bs=$t+$a-1"
bs=$( echo -e "\\$bs" ) #convert to character

MYPV="${PV/.${t}_beta/beta}${bs}"
MYP="${PN}-${MYPV}"

######################## End version Munge ##########################

S=${WORKDIR}/${MYP}

DESCRIPTION="Advanced Linux Sound Architecture Utils"

SRC_URI="ftp://ftp.alsa-project.org/pub/utils/${MYP}.tar.bz2"

HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1
	=media-libs/alsa-lib-0.9.0.1_beta10"


src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	
	emake || die "Parallel Make Failed"

}

src_install() {
	
	ALSA_UTILS_DOCS="COPYING ChangeLog README TODO 
			seq/aconnect/README.aconnect 
			seq/aseqnet/README.aseqnet"
	
	make DESTDIR=${D} install || die "Installation Failed"
	
	dodoc ${ALSA_UTILS_DOCS}
	newdoc alsamixer/README README.alsamixer
	exeinto /etc/init.d 
	newexe ${FILESDIR}/alsa.rc6 alsa

}
