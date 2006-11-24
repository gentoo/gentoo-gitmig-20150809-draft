--- trunk/mono/mono/io-layer/process-private.h	2006/05/12 10:38:20	60618
+++ trunk/mono/mono/io-layer/process-private.h	2006/11/23 00:39:10	68378
@@ -31,6 +31,7 @@
 	gchar proc_name[_WAPI_PROC_NAME_MAX_LEN];
 	size_t min_working_set;
 	size_t max_working_set;
+	gboolean waited;
 };
 
 extern void _wapi_process_reap (void);

--- trunk/mono/mono/io-layer/processes.c	2006/11/18 19:02:51	68130
+++ trunk/mono/mono/io-layer/processes.c	2006/11/23 00:39:10	68378
@@ -80,6 +80,10 @@
 		process_handle->exitstatus = WEXITSTATUS(status);
 	}
 	_wapi_time_t_to_filetime (time(NULL), &process_handle->exit_time);
+
+	/* Don't set process_handle->waited here, it needs to only
+	 * happen in the parent when wait() has been called.
+	 */
 	
 #ifdef DEBUG
 	g_message ("%s: Setting handle %p signalled", __func__, handle);
@@ -108,17 +112,17 @@
 	int status;
 	pid_t ret;
 	
-	if (_wapi_handle_issignalled (test)) {
-		/* We've already done this one */
-		return (FALSE);
-	}
-	
 	ok = _wapi_lookup_handle (test, WAPI_HANDLE_PROCESS,
 				  (gpointer *)&process);
 	if (ok == FALSE) {
 		/* The handle must have been too old and was reaped */
 		return (FALSE);
 	}
+
+	if (process->waited) {
+		/* We've already done this one */
+		return(FALSE);
+	}
 	
 	do {
 		ret = waitpid (process->id, &status, WNOHANG);
@@ -138,6 +142,8 @@
 	g_message ("%s: Process %d finished", __func__, ret);
 #endif
 
+	process->waited = TRUE;
+	
 	*(int *)user_data = status;
 	
 	return (TRUE);
@@ -185,8 +191,16 @@
 #ifdef DEBUG
 	g_message ("%s: Waiting for process %p", __func__, handle);
 #endif
+
+	ok = _wapi_lookup_handle (handle, WAPI_HANDLE_PROCESS,
+				  (gpointer *)&process_handle);
+	if (ok == FALSE) {
+		g_warning ("%s: error looking up process handle %p", __func__,
+			   handle);
+		return(WAIT_FAILED);
+	}
 	
-	if (_wapi_handle_issignalled (handle)) {
+	if (process_handle->waited) {
 		/* We've already done this one */
 #ifdef DEBUG
 		g_message ("%s: Process %p already signalled", __func__,
@@ -195,14 +209,6 @@
 
 		return (WAIT_OBJECT_0);
 	}
-
-	ok = _wapi_lookup_handle (handle, WAPI_HANDLE_PROCESS,
-				  (gpointer *)&process_handle);
-	if (ok == FALSE) {
-		g_warning ("%s: error looking up process handle %p", __func__,
-			   handle);
-		return(WAIT_FAILED);
-	}
 	
 	pid = process_handle->id;
 	
@@ -211,9 +217,15 @@
 #endif
 
 	if (timeout == INFINITE) {
-		while ((ret = waitpid (pid, &status, 0)) != pid) {
-			if (ret == (pid_t)-1 && errno != EINTR) {
-				return(WAIT_FAILED);
+		if (pid == _wapi_getpid ()) {
+			do {
+				Sleep (10000);
+			} while(1);
+		} else {
+			while ((ret = waitpid (pid, &status, 0)) != pid) {
+				if (ret == (pid_t)-1 && errno != EINTR) {
+					return(WAIT_FAILED);
+				}
 			}
 		}
 	} else if (timeout == 0) {
@@ -224,18 +236,47 @@
 		}
 	} else {
 		/* Poll in a loop */
-		do {
-			ret = waitpid (pid, &status, WNOHANG);
-			if (ret == pid) {
-				break;
-			} else if (ret == (pid_t)-1 && errno != EINTR) {
-				return(WAIT_FAILED);
-			}
+		if (pid == _wapi_getpid ()) {
+			Sleep (timeout);
+			return(WAIT_TIMEOUT);
+		} else {
+			do {
+				ret = waitpid (pid, &status, WNOHANG);
+#ifdef DEBUG
+				g_message ("%s: waitpid returns: %d, timeout is %d", __func__, ret, timeout);
+#endif
+				
+				if (ret == pid) {
+					break;
+				} else if (ret == (pid_t)-1 &&
+					   errno != EINTR) {
+#ifdef DEBUG
+					g_message ("%s: waitpid failure: %s",
+						   __func__,
+						   g_strerror (errno));
+#endif
 
-			_wapi_handle_spin (100);
-			timeout -= 100;
-		} while (timeout > 0);
+					if (errno == ECHILD &&
+					    process_handle->waited) {
+						/* The background
+						 * process reaper must
+						 * have got this one
+						 */
+#ifdef DEBUG
+						g_message ("%s: Process %p already reaped", __func__, handle);
+#endif
 
+						return(WAIT_OBJECT_0);
+					} else {
+						return(WAIT_FAILED);
+					}
+				}
+
+				_wapi_handle_spin (100);
+				timeout -= 100;
+			} while (timeout > 0);
+		}
+		
 		if (timeout <= 0) {
 			return(WAIT_TIMEOUT);
 		}
@@ -251,7 +292,8 @@
 		SetLastError (ERROR_OUTOFMEMORY);
 		return (WAIT_FAILED);
 	}
-
+	process_handle->waited = TRUE;
+	
 	return(WAIT_OBJECT_0);
 }
 
@@ -268,6 +310,8 @@
 	process_handle->min_working_set = 204800;
 	process_handle->max_working_set = 1413120;
 
+	process_handle->waited = FALSE;
+	
 	_wapi_time_t_to_filetime (time (NULL), &process_handle->create_time);
 }
 
@@ -919,6 +963,11 @@
 		g_strfreev (env_strings);
 	}
 	
+#ifdef DEBUG
+	g_message ("%s: returning handle %p for pid %d", __func__, handle,
+		   pid);
+#endif
+
 	return(ret);
 }
 		
@@ -960,6 +1009,8 @@
 	const char *handle_env;
 	struct _WapiHandle_process process_handle = {0};
 	
+	mono_once (&process_ops_once, process_ops_init);
+	
 	handle_env = g_getenv ("_WAPI_PROCESS_HANDLE_OFFSET");
 	g_unsetenv ("_WAPI_PROCESS_HANDLE_OFFSET");
 	
--- trunk/mono/mono/io-layer/wapi-private.h	2006/03/24 12:19:30	58409
+++ trunk/mono/mono/io-layer/wapi-private.h	2006/11/23 00:39:10	68378
@@ -24,8 +24,7 @@
 /* Increment this whenever an incompatible change is made to the
  * shared handle structure.
  */
-/* Next time I change this, remember to fix the process count in shared.c */
-#define _WAPI_HANDLE_VERSION 10
+#define _WAPI_HANDLE_VERSION 11
 
 typedef enum {
 	WAPI_HANDLE_UNUSED=0,

--- trunk/mono/mono/io-layer/shared.c	2006/07/25 12:56:51	62955
+++ trunk/mono/mono/io-layer/shared.c	2006/11/23 00:39:10	68378
@@ -292,12 +292,11 @@
 	for (i = 0; i < _WAPI_SHARED_SEM_COUNT; i++) {
 		def_vals[i] = 1;
 	}
-#ifdef NEXT_VERSION_INC
+
 	/* Process count must start at '0' - the 1 for all the others
 	 * sets the semaphore to "unlocked"
 	 */
 	def_vals[_WAPI_SHARED_SEM_PROCESS_COUNT] = 0;
-#endif
 	
 	defs.array = def_vals;
 	
@@ -438,19 +437,9 @@
 	
 	proc_count = semctl (_wapi_sem_id, _WAPI_SHARED_SEM_PROCESS_COUNT,
 			     GETVAL);
-#ifdef NEXT_VERSION_INC
+
 	g_assert (proc_count > 0);
 	if (proc_count == 1) {
-#else
-	/* Compatibility - the semaphore was initialised to '1' (which
-	 * normally means 'unlocked'.  Instead of fixing that right
-	 * now, which would mean a shared file version increment, just
-	 * cope with the value starting too high for now.  Fix this
-	 * next time I have to change the file version.
-	 */
-	g_assert (proc_count > 1);
-	if (proc_count == 2) {
-#endif
 		/* Just us, so blow away the semaphores and the shared
 		 * files
 		 */
