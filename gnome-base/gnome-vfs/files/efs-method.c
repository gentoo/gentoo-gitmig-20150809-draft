/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 8; tab-width: 8 -*- */
/* file-method.c - Local file access method for the GNOME Virtual File
   System.

   Copyright (C) 1999 Free Software Foundation

   The Gnome Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The Gnome Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the Gnome Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.

   Authors: Rajit Singh   <endah@dircon.co.uk>
            Michael Meeks <mmeeks@gnu.org>
*/

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <gnome.h>
#include "gnome-vfs.h"
#include "gnome-vfs-mime.h"
#include "gnome-vfs-module.h"
#include "gnome-vfs-module-shared.h"
#include "efs-method.h"

typedef struct _GnomeVFSFileSystem GnomeVFSFileSystem;

typedef GnomeVFSResult (*GnomeVFSFileSystemCloseFn) (GnomeVFSFileSystem *fs);

struct _GnomeVFSFileSystem {
	guint32                    ref_count;

	GMutex                    *lock;
	GnomeVFSURI               *location;
	GnomeVFSFileSystemCloseFn  close_fn;
};

/*
 * Locks the ref count and the open list.
 */
static GStaticMutex   vfs_open_file_systems_lock = G_STATIC_MUTEX_INIT;
static GSList        *vfs_open_file_systems     = NULL;

static GnomeVFSFileSystem *
gnome_vfs_file_system_lookup (GnomeVFSURI *location)
{
	GSList             *l;
	GnomeVFSFileSystem *fs = NULL;

	g_return_val_if_fail (location != NULL, NULL);

	g_static_mutex_lock   (&vfs_open_file_systems_lock);
	{
		for (l = vfs_open_file_systems; l; l = l->next) {
			GnomeVFSFileSystem *tfs = l->data;

			if (gnome_vfs_uri_equal (location, tfs->location)) {
				tfs->ref_count++;
				fs = tfs;
				break;
			}
		}
	}
	g_static_mutex_unlock (&vfs_open_file_systems_lock);

	return fs;
}

static GnomeVFSFileSystem *
gnome_vfs_file_system_add (GnomeVFSURI               *location,
			   GnomeVFSFileSystemCloseFn  close_fn,
			   guint                      size)
{
	GnomeVFSFileSystem *fs;

	g_return_val_if_fail (close_fn != NULL, NULL);
	g_return_val_if_fail (location != NULL, NULL);
	g_return_val_if_fail (
		gnome_vfs_file_system_lookup (location) == NULL, NULL);

	fs = g_malloc0 (size);

	fs->lock      = g_mutex_new ();
	fs->ref_count = 1;
	fs->close_fn  = close_fn;
	fs->location  = gnome_vfs_uri_ref (location);

	g_static_mutex_lock   (&vfs_open_file_systems_lock);
	{
		vfs_open_file_systems = g_slist_prepend (
			vfs_open_file_systems, fs);
	}
	g_static_mutex_unlock (&vfs_open_file_systems_lock);

	return fs;
}

static GnomeVFSFileSystem *
gnome_vfs_file_system_ref (GnomeVFSFileSystem *fs)
{
	g_return_val_if_fail (fs != NULL, NULL);

	g_static_mutex_lock (&vfs_open_file_systems_lock);
		fs->ref_count++;
	g_static_mutex_unlock (&vfs_open_file_systems_lock);

	return fs;
}

static void
gnome_vfs_file_system_lock (GnomeVFSFileSystem *fs)
{
	g_return_if_fail (fs != NULL);
	g_return_if_fail (fs->ref_count > 0);

	g_mutex_lock (fs->lock);
}

static void
gnome_vfs_file_system_unlock (GnomeVFSFileSystem *fs)
{
	g_return_if_fail (fs != NULL);
	g_return_if_fail (fs->ref_count > 0);

	g_mutex_unlock (fs->lock);
}

static GnomeVFSResult
gnome_vfs_file_system_unref (GnomeVFSFileSystem *fs)
{
	GnomeVFSResult result;

	g_return_val_if_fail (fs != NULL, GNOME_VFS_ERROR_INTERNAL);

	g_static_mutex_lock (&vfs_open_file_systems_lock);
	{
		fs->ref_count--;
		if (fs->ref_count == 0) {

			gnome_vfs_uri_unref (fs->location);
			result = fs->close_fn (fs);
			if (!g_mutex_trylock (fs->lock))
				g_warning ("Release fs lock before unref");
			else
				g_mutex_unlock (fs->lock);
			g_mutex_free (fs->lock);
			g_free (fs);

			vfs_open_file_systems = g_slist_remove (
				vfs_open_file_systems, fs);
		} else
			result = GNOME_VFS_OK;
	}
	g_static_mutex_unlock (&vfs_open_file_systems_lock);

	return result;
}

static void
gnome_vfs_file_system_init (void)
{
	if (!g_thread_supported()) g_thread_init (NULL);
}

static void
gnome_vfs_file_system_shutdown (void)
{
	g_static_mutex_lock (&vfs_open_file_systems_lock);
	if (vfs_open_file_systems)
		g_warning ("Implement shutdown\n");
	g_static_mutex_unlock (&vfs_open_file_systems_lock);
}



typedef struct {
	GnomeVFSFileSystem fs;
	
	EFSDir            *dir;
} VEfsFileSystem;

struct _FileHandle {
	GnomeVFSURI        *uri;
	GnomeVFSFileSystem *fs;
	EFSFile            *file;
};
typedef struct _FileHandle FileHandle;

static FileHandle *
file_handle_new (GnomeVFSURI        *uri,
		 GnomeVFSFileSystem *fs,
		 EFSFile            *file)
{
	FileHandle *new;

	g_return_val_if_fail (fs != NULL, NULL);
	g_return_val_if_fail (uri != NULL, NULL);
	g_return_val_if_fail (file != NULL, NULL);

	new = g_new (FileHandle, 1);

	new->uri  = gnome_vfs_uri_ref (uri);
	new->fs   = fs;
	new->file = file;

	return new;
}

static GnomeVFSResult
file_handle_destroy (FileHandle *handle)
{
	GnomeVFSResult result;

	gnome_vfs_uri_unref (handle->uri);
	result = gnome_vfs_file_system_unref (
		(GnomeVFSFileSystem *)handle->fs);

	g_free (handle);

	return result;
}



static GnomeVFSResult
close_efs_file (GnomeVFSFileSystem *fs)
{
	VEfsFileSystem *efs = (VEfsFileSystem *)fs;

	if (efs_commit (efs->dir) < 0)
		return gnome_vfs_result_from_errno ();
	else if (efs_close (efs->dir) < 0)
		return gnome_vfs_result_from_errno ();
	else
		return GNOME_VFS_OK;
}

#define ROOT_DIR(fs) (((VEfsFileSystem *)(fs))->dir)

static GnomeVFSResult
open_efs_file (GnomeVFSFileSystem **fs, GnomeVFSURI *uri, gint mode)
{
	GnomeVFSResult  result;

	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri->parent != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri->parent->text != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (strcmp (uri->parent->method_string, "file") == 0);

	*fs = gnome_vfs_file_system_lookup (uri->parent);

	if (*fs) {
		fprintf (stderr, "FS reused\n");
		result = GNOME_VFS_OK;
	} else {
		char   *fname, *bname;
		EFSDir *dir;

		bname = uri->parent->text;
		if (bname [0] != '/')
			fname = g_strconcat ("/", bname, NULL);
		else
			fname = g_strdup (bname);

		fprintf (stderr, "New EFS file system: '%s'\n", fname);

		efs_open (&dir,fname, mode, default_permissions,NULL);

		if (!dir) {
			result = gnome_vfs_result_from_errno ();
			if (!result)
				result = GNOME_VFS_ERROR_INTERNAL;
		} else {
			*fs = gnome_vfs_file_system_add
				(uri->parent, close_efs_file,
				 sizeof (VEfsFileSystem));

			ROOT_DIR (*fs) = dir;

			result = GNOME_VFS_OK;
		}
		
		g_free (fname);
	}

	return result;
}

static GnomeVFSResult
do_open (GnomeVFSMethod *method,
	 GnomeVFSMethodHandle **method_handle,
	 GnomeVFSURI *uri,
	 GnomeVFSOpenMode mode,
	 GnomeVFSContext *context)
{
	GnomeVFSResult result;
	FileHandle *file_handle;
	GnomeVFSFileSystem *fs;
	EFSFile            *file;
	mode_t              efs_mode;

	if (mode & GNOME_VFS_OPEN_READ) {
		if (mode & GNOME_VFS_OPEN_WRITE)
			efs_mode = EFS_RDWR | EFS_CREATE;
		else
			efs_mode = EFS_READ;
	} else {
		if (mode & GNOME_VFS_OPEN_WRITE)
			efs_mode = EFS_WRITE | EFS_CREATE;
		else
			return GNOME_VFS_ERROR_INVALID_OPEN_MODE;
	}
	
	result = open_efs_file (&fs, uri, efs_mode);
	if (result != GNOME_VFS_OK)
		return result;

	efs_mode |= EFS_CREATE;

	gnome_vfs_file_system_lock (fs);
		efs_file_open (&file, ROOT_DIR (fs), uri->text, efs_mode);
	gnome_vfs_file_system_unlock (fs);

	if (!file) {
		gnome_vfs_file_system_unref (fs);
		return GNOME_VFS_ERROR_GENERIC;
	}

	file_handle = file_handle_new (uri, fs, file);
	
	*method_handle = (GnomeVFSMethodHandle *) file_handle;

	return GNOME_VFS_OK;
}

static GnomeVFSResult
do_create (GnomeVFSMethod *method,
	   GnomeVFSMethodHandle **method_handle,
	   GnomeVFSURI *uri,
	   GnomeVFSOpenMode mode,
	   gboolean exclusive,
	   guint perm,
	   GnomeVFSContext *context)
{
	GnomeVFSResult result;
	FileHandle *file_handle;
	GnomeVFSFileSystem *fs;
	EFSFile *file;
	mode_t efs_mode;

	_GNOME_VFS_METHOD_PARAM_CHECK (method_handle != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);

	efs_mode = EFS_CREATE;
	
	if (!(mode & GNOME_VFS_OPEN_WRITE))
		return GNOME_VFS_ERROR_INVALID_OPEN_MODE;

	if (mode & GNOME_VFS_OPEN_READ)
		efs_mode |= EFS_RDWR;
	else
		efs_mode |= EFS_WRITE;

	if (exclusive)
		efs_mode |= EFS_EXCL;

	result = open_efs_file (&fs, uri, efs_mode);

	if (result != GNOME_VFS_OK)
		return result;

	gnome_vfs_file_system_lock (fs);
		efs_file_open (&file, ROOT_DIR (fs), uri->text, efs_mode);
	gnome_vfs_file_system_unlock (fs);
	if (!file) {
		gnome_vfs_file_system_unref (fs);
		return GNOME_VFS_ERROR_GENERIC;
	}

	file_handle = file_handle_new (uri, fs, file);

	*method_handle = (GnomeVFSMethodHandle *) file_handle;

	return GNOME_VFS_OK;
}

static GnomeVFSResult
do_close (GnomeVFSMethod *method,
	  GnomeVFSMethodHandle *method_handle,
	  GnomeVFSContext *context)
{
	GnomeVFSResult result;
	FileHandle    *file_handle;

	g_return_val_if_fail (method_handle != NULL, GNOME_VFS_ERROR_INTERNAL);

	file_handle = (FileHandle *) method_handle;

	gnome_vfs_file_system_lock (file_handle->fs);
	{
		if (efs_file_close (file_handle->file) < 0)
			result = gnome_vfs_result_from_errno ();
	}
	gnome_vfs_file_system_unlock (file_handle->fs);

	if (!result)
		result = file_handle_destroy (file_handle);

	return result;
}

static GnomeVFSResult
do_read (GnomeVFSMethod *method,
	 GnomeVFSMethodHandle *method_handle,
	 gpointer buffer,
	 GnomeVFSFileSize num_bytes,
	 GnomeVFSFileSize *bytes_read,
	 GnomeVFSContext *context)
{
	FileHandle *file_handle;
	gint read_val;

	g_return_val_if_fail (method_handle != NULL, GNOME_VFS_ERROR_INTERNAL);

	file_handle = (FileHandle *) method_handle;

	gnome_vfs_file_system_lock (file_handle->fs);
		efs_file_read (file_handle->file, buffer, num_bytes, &read_val);
	gnome_vfs_file_system_unlock (file_handle->fs);	

	if (read_val == -1) {
		*bytes_read = 0;
		return gnome_vfs_result_from_errno ();
	} else {
		*bytes_read = read_val;
		return GNOME_VFS_OK;
	}
}

static GnomeVFSResult
do_write (GnomeVFSMethod *method,
	  GnomeVFSMethodHandle *method_handle,
	  gconstpointer buffer,
	  GnomeVFSFileSize num_bytes,
	  GnomeVFSFileSize *bytes_written,
	  GnomeVFSContext *context)
{
	FileHandle *file_handle;
	gint write_val;

	g_return_val_if_fail (method_handle != NULL, GNOME_VFS_ERROR_INTERNAL);

	file_handle = (FileHandle *) method_handle;

	gnome_vfs_file_system_lock (file_handle->fs);
		write_val = efs_file_write (file_handle->file, (void *) buffer, num_bytes);
	gnome_vfs_file_system_unlock (file_handle->fs);

	if (write_val == -1) {
		*bytes_written = 0;
		return gnome_vfs_result_from_errno ();
	} else {
		*bytes_written = write_val;
		return GNOME_VFS_OK;
	}
}


static gint
seek_position_to_unix (GnomeVFSSeekPosition position)
{
	switch (position) {
	case GNOME_VFS_SEEK_START:
		return SEEK_SET;
	case GNOME_VFS_SEEK_CURRENT:
		return SEEK_CUR;
	case GNOME_VFS_SEEK_END:
		return SEEK_END;
	default:
		g_warning (_("Unknown GnomeVFSSeekPosition %d"), position);
		return SEEK_SET; /* bogus */
	}
}

static GnomeVFSResult
do_seek (GnomeVFSMethod *method,
	 GnomeVFSMethodHandle *method_handle,
	 GnomeVFSSeekPosition whence,
	 GnomeVFSFileOffset offset,
	 GnomeVFSContext *context)
{
	FileHandle *file_handle;
	gint lseek_whence, retval;

	file_handle = (FileHandle *) method_handle;
	lseek_whence = seek_position_to_unix (whence);

	gnome_vfs_file_system_lock (file_handle->fs);
	efs_file_seek (file_handle->file, offset, lseek_whence, &retval);
	gnome_vfs_file_system_unlock (file_handle->fs);
	
	if (retval == -1)
		return gnome_vfs_result_from_errno ();

	return GNOME_VFS_OK;
}

static GnomeVFSResult
do_tell (GnomeVFSMethod       *method,
	 GnomeVFSMethodHandle *method_handle,
	 GnomeVFSFileOffset   *offset_return)
{
	FileHandle *file_handle;
	gint        retval;

	file_handle = (FileHandle *) method_handle;

	gnome_vfs_file_system_lock (file_handle->fs);
	efs_file_seek (file_handle->file, 0, SEEK_CUR, &retval);
	gnome_vfs_file_system_unlock (file_handle->fs);

	*offset_return = retval;

	if (retval == -1)
		return gnome_vfs_result_from_errno ();

	return GNOME_VFS_OK;
}

static GnomeVFSResult
do_truncate_handle (GnomeVFSMethod *method,
		    GnomeVFSMethodHandle *method_handle,
		    GnomeVFSFileSize where,
		    GnomeVFSContext *context)
{
	FileHandle    *file_handle;
	GnomeVFSResult result;

	g_return_val_if_fail (method_handle != NULL, GNOME_VFS_ERROR_INTERNAL);

	file_handle = (FileHandle *) method_handle;

	gnome_vfs_file_system_lock (file_handle->fs);
	{
		if (efs_file_trunc (file_handle->file, where) < 0)
			result = gnome_vfs_result_from_errno ();
		else
			result = GNOME_VFS_OK;
	}
	gnome_vfs_file_system_unlock (file_handle->fs);

	return result;
}

static GnomeVFSResult
do_truncate (GnomeVFSMethod *method,
	     GnomeVFSURI *uri,
	     GnomeVFSFileSize where,
	     GnomeVFSContext *context)
{
  	FileHandle           *file_handle;
	GnomeVFSMethodHandle *method_handle;
	GnomeVFSResult        result;

	_GNOME_VFS_METHOD_PARAM_CHECK (method_handle != NULL && (strcmp(uri->method_string, "file") == 0));
	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);

	if ((result = do_open (method, &method_handle, uri, EFS_WRITE, context))) {
	 	file_handle = (FileHandle *) method_handle;

		gnome_vfs_file_system_lock (file_handle->fs);
		{
			if ((result = efs_file_trunc (file_handle->file, where) == 0))
				do_close (method, method_handle, context);
		}
		gnome_vfs_file_system_unlock (file_handle->fs);
	}

	return result;
}


struct _DirectoryHandle {
	GnomeVFSURI        *uri;
	GnomeVFSFileSystem *fs;
	EFSDir             *dir;
	GnomeVFSFileInfoOptions       options;
	const GnomeVFSDirectoryFilter *filter;
};
typedef struct _DirectoryHandle DirectoryHandle;

static GnomeVFSResult
directory_handle_destroy (DirectoryHandle *directory_handle)
{
	GnomeVFSResult result;

	gnome_vfs_uri_unref (directory_handle->uri);
	result = gnome_vfs_file_system_unref (directory_handle->fs);
	g_free (directory_handle);

	return result;
}


static GnomeVFSResult
do_open_directory (GnomeVFSMethod *method,
		   GnomeVFSMethodHandle **method_handle,
		   GnomeVFSURI *uri,
		   GnomeVFSFileInfoOptions options,
		   const GnomeVFSDirectoryFilter *filter,
		   GnomeVFSContext *context)
{
	GnomeVFSResult      result;
	GnomeVFSFileSystem *fs;
	EFSDir             *dir;
	DirectoryHandle    *handle;

	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri->text != NULL);

	result = open_efs_file (&fs, uri, EFS_READ);
	if (result != GNOME_VFS_OK)
		return result;

	efs_dir_open (&dir, ROOT_DIR (fs), uri->text, EFS_READ);
	if (!dir)
		result = gnome_vfs_result_from_errno ();
	else {
		handle = g_new (DirectoryHandle, 1);
		
		handle->uri = gnome_vfs_uri_ref (uri);
		handle->fs  = gnome_vfs_file_system_ref (fs);
		handle->dir = dir;
		handle->options = options;
		handle->filter = filter;

		*method_handle = (GnomeVFSMethodHandle *)handle;

		result = GNOME_VFS_OK;
	}

	if (!result)
		result = gnome_vfs_file_system_unref (fs);
	else
		gnome_vfs_file_system_unref (fs);

	return result;
}

static GnomeVFSResult
do_close_directory (GnomeVFSMethod *method,
		    GnomeVFSMethodHandle *method_handle,
		    GnomeVFSContext *context)
{
	DirectoryHandle *directory_handle;

	directory_handle = (DirectoryHandle *) method_handle;

	gnome_vfs_file_system_lock (directory_handle->fs);
		efs_dir_close (directory_handle->dir);
	gnome_vfs_file_system_unlock (directory_handle->fs);

	return directory_handle_destroy (directory_handle);
}

static void
transfer_dir_to_info (GnomeVFSFileInfo *info, EFSDirEntry *entry)
{
	info->name = g_strdup (entry->name);
	if (entry->type == EFS_DIR)
		info->type = GNOME_VFS_FILE_TYPE_DIRECTORY;
	else if (entry->type == EFS_FILE)
		info->type = GNOME_VFS_FILE_TYPE_REGULAR;
	else
		info->type = GNOME_VFS_FILE_TYPE_UNKNOWN;

	info->size = entry->length;

	info->valid_fields =
		GNOME_VFS_FILE_INFO_FIELDS_TYPE |
		GNOME_VFS_FILE_INFO_FIELDS_SIZE;

}

static GnomeVFSResult
do_read_directory (GnomeVFSMethod *method,
		   GnomeVFSMethodHandle *method_handle,
		   GnomeVFSFileInfo *info,
		   GnomeVFSContext *context)
{
	DirectoryHandle *directory_handle;
	EFSDirEntry     *entry;

	directory_handle = (DirectoryHandle *) method_handle;
	if (!directory_handle || !directory_handle->fs ||
	    !ROOT_DIR (directory_handle->fs))
		return GNOME_VFS_ERROR_INTERNAL;

	gnome_vfs_file_system_lock (directory_handle->fs);
	efs_dir_read (directory_handle->dir,entry);
	gnome_vfs_file_system_unlock (directory_handle->fs);
	if (!entry)
		return GNOME_VFS_ERROR_EOF;

	transfer_dir_to_info (info, entry);

	return GNOME_VFS_OK;
}


static GnomeVFSResult
do_get_file_info (GnomeVFSMethod *method,
		  GnomeVFSURI *uri,
		  GnomeVFSFileInfo *info,
		  GnomeVFSFileInfoOptions options,
		  GnomeVFSContext *context)
{
	char *dir_name, *fname;
	GnomeVFSFileSystem *fs;
	EFSDir             *dir;
	GnomeVFSResult      result;

	/*
	 * 1. Get the directory / file names split.
	 */
	dir_name = g_strdup (uri->text?uri->text:"");
	if ((fname = strrchr (dir_name, '/'))) {
		*fname = '\0';
		fname++;
	} else {
		fname = dir_name;
		dir_name = g_strconcat ("/ ", dir_name, NULL);
		g_free (fname);
		fname = dir_name + 2;
		dir_name [1] = '\0';
	}
	
	/*
	 * 2. If we are just looking for root then; return parent data.
	 */
	if (strlen  (fname) == 0 ||
	    strlen  (dir_name) == 0 ||
	    !strcmp (dir_name, "/")) {
		g_free (dir_name);

		if (uri->parent->method->get_file_info == NULL)
			return GNOME_VFS_ERROR_NOT_SUPPORTED;

		result = uri->parent->method->get_file_info
			(uri->parent->method, uri->parent,
			 info, options, context);
		if (result != GNOME_VFS_OK)
			return result;

		/*
		 * Fiddle the info so it looks like a directory.
		 */
		if (info->valid_fields & GNOME_VFS_FILE_INFO_FIELDS_TYPE) {
			if (info->type != GNOME_VFS_FILE_TYPE_DIRECTORY)
				info->type = GNOME_VFS_FILE_TYPE_DIRECTORY;
			else { 
				/*
				 * Ug, we can't put an efs file in a directory.
				 */ 
				return GNOME_VFS_ERROR_IS_DIRECTORY;
			}
		} else {
			info->valid_fields |= GNOME_VFS_FILE_INFO_FIELDS_TYPE;
			info->type = GNOME_VFS_FILE_TYPE_DIRECTORY;
		}
		return GNOME_VFS_OK;
	}

	/*
	 * 3. Open the efs directory.
	 */
	result = open_efs_file (&fs, uri, EFS_READ);
	if (result != GNOME_VFS_OK)
		return result;

	gnome_vfs_file_system_lock (fs);
	{
		efs_dir_open (&dir, ROOT_DIR (fs), dir_name, EFS_READ);
		if (!dir) {
			result = gnome_vfs_result_from_errno ();
			gnome_vfs_file_system_unref (fs);
			g_free (dir_name);
		}
	}
	gnome_vfs_file_system_unlock (fs);

	if (result)
		return result;

	/*
	 * 4. Iterate over the files
	 */
	result = GNOME_VFS_ERROR_NOT_FOUND;
	while (1) {
		EFSDirEntry     *entry;
		
		gnome_vfs_file_system_lock (fs);
		efs_dir_read (dir, entry);
		gnome_vfs_file_system_unlock (fs);

		if (!entry)
			break;

		if (!strcmp (fname, entry->name)) {
			transfer_dir_to_info (info, entry);
			result = GNOME_VFS_OK;
			break;
		}
	}
	gnome_vfs_file_system_lock (fs);
		efs_dir_close (dir);
	gnome_vfs_file_system_unlock (fs);
	
	if (!result)
		result = gnome_vfs_file_system_unref (fs);
	else
		gnome_vfs_file_system_unref (fs);

	return result;
}


static gboolean
do_is_local (GnomeVFSMethod *method,
	     const GnomeVFSURI *uri)
{
	g_return_val_if_fail (uri != NULL, FALSE);

	/* We are always a native filesystem.  */
	return TRUE;
}


static GnomeVFSResult
do_make_directory (GnomeVFSMethod *method,
		   GnomeVFSURI *uri,
		   guint perm,
		   GnomeVFSContext *context)
{
	GnomeVFSResult      result;
	GnomeVFSFileSystem *fs;
	EFSDir *dir;

	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri->text != NULL);

	result = open_efs_file (&fs, uri, EFS_RDWR | EFS_CREATE);
	if (result != GNOME_VFS_OK)
		return result;

	gnome_vfs_file_system_lock (fs);
	{
		efs_dir_open (&dir,ROOT_DIR (fs), uri->text, EFS_CREATE|EFS_EXCL);
		if (!dir)
			result = GNOME_VFS_ERROR_FILE_EXISTS;
		else
			result = GNOME_VFS_OK;
	}
	gnome_vfs_file_system_unlock (fs);

	if (!result)
		result = gnome_vfs_file_system_unref (fs);
	else
		gnome_vfs_file_system_unref (fs);

	return result;
}

static GnomeVFSResult
do_remove_directory (GnomeVFSMethod *method,
		     GnomeVFSURI *uri,
		     GnomeVFSContext *context)
{
	return GNOME_VFS_ERROR_NOT_SUPPORTED;
}

static GnomeVFSResult
do_find_directory (GnomeVFSMethod *method,
		   GnomeVFSURI *near_uri,
		   GnomeVFSFindDirectoryKind kind,
		   GnomeVFSURI **result_uri,
		   gboolean create_if_needed,
		   guint permissions,
		   GnomeVFSContext *context)
{
	return GNOME_VFS_ERROR_NOT_SUPPORTED;
}

static GnomeVFSResult
do_move (GnomeVFSMethod *method,
	 GnomeVFSURI *old_uri,
	 GnomeVFSURI *new_uri,
	 gboolean force_replace,
	 GnomeVFSContext *context)
{
	return GNOME_VFS_ERROR_NOT_SUPPORTED;
}

static GnomeVFSResult
do_unlink (GnomeVFSMethod *method,
	   GnomeVFSURI *uri,
	   GnomeVFSContext *context)
{
	GnomeVFSResult      result;
	GnomeVFSFileSystem *fs;

	_GNOME_VFS_METHOD_PARAM_CHECK (uri != NULL);
	_GNOME_VFS_METHOD_PARAM_CHECK (uri->text != NULL);

	result = open_efs_file (&fs, uri, EFS_RDWR);
	if (result != GNOME_VFS_OK)
		return result;

	gnome_vfs_file_system_lock (fs);
	{
		if (!efs_erase (ROOT_DIR (fs), uri->text))
			result = gnome_vfs_result_from_errno ();
	}
	gnome_vfs_file_system_unlock (fs);

	if (!result)
		result = gnome_vfs_file_system_unref (fs);
	else
		gnome_vfs_file_system_unref (fs);

	return result;
}

static GnomeVFSResult
do_check_same_fs (GnomeVFSMethod *method,
		  GnomeVFSURI *a,
		  GnomeVFSURI *b,
		  gboolean *same_fs_return,
		  GnomeVFSContext *context)
{
	return GNOME_VFS_ERROR_NOT_SUPPORTED;
}

static GnomeVFSResult
do_set_file_info (GnomeVFSMethod *method,
		  GnomeVFSURI *uri,
		  const GnomeVFSFileInfo *info,
		  GnomeVFSSetFileInfoMask mask,
		  GnomeVFSContext *context)
{
	return GNOME_VFS_ERROR_NOT_SUPPORTED;
}

static GnomeVFSMethod method = {
	do_open,
	do_create,
	do_close,
	do_read,
	do_write,
	do_seek,
	do_tell,
	do_truncate_handle,
	do_open_directory,
	do_close_directory,
	do_read_directory,
	do_get_file_info,
	NULL,
	do_is_local,
	do_make_directory,
	do_remove_directory,
	do_move,
	do_unlink,
	do_check_same_fs,
	do_set_file_info,
	do_truncate,
	do_find_directory
};

GnomeVFSMethod *
vfs_module_init (const char *method_name, const char *args)
{
	gnome_vfs_file_system_init ();
	return &method;
}

void
vfs_module_shutdown (GnomeVFSMethod *method)
{
	gnome_vfs_file_system_shutdown ();
}
